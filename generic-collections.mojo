from memory.memory import memcpy

@value
@register_passable("trivial")
struct DodgyString:
    var data: Pointer[Int8]
    var len: Int

    fn __init__(str: StringLiteral) -> DodgyString:
        let l = str.__len__()
        let s = String(str)
        let p = Pointer[Int8].alloc(l)
        for i in range(l):
            p.store(i, s._buffer[i])
        return DodgyString(p, l)

    fn to_string(self) -> String:
        let s = String(self.data, self.len)
        return s

struct Array[T: AnyType]:
    var real_list: Pointer[T]
    var length: Int
    
    fn __init__(inout self, length: Int = 0) -> None:
        self.length = length
        self.real_list = Pointer[T].alloc(self.length)

    fn __getitem__(owned self, i: Int) -> T:
        return self.real_list.load(i)

    fn __setitem__(inout self, loc: Int, item: T) -> None:
        self.real_list.store(loc, item)

    fn __copyinit__(inout self, other: Self):
        self.length = other.length
        self.real_list = Pointer[T].alloc(self.length)
        memcpy[T](self.real_list, other.real_list, self.length)

    fn apply_function[T2: AnyType, func: fn(T) -> T2](owned self) -> Array[T2]:
        var result = Array[T2](self.length)
        for loc in range(self.length):
            let item = self[loc]
            result[loc] = func(item)
        return result

fn add_two(x: Int) -> Int:
    return x + 2

fn make_string_array_ints(x: DodgyString) -> Int:
    let s = x.to_string()
    try:
        let i = atol(s)
        return i
    except:
        print("warning text:", s, "doesn't convert to Int so returning 0")
        return 0

fn main():
    var s_array = Array[DodgyString](3)
    s_array[0] = "notnumber"
    s_array[1] = "1"
    s_array[2] = "42"

    print("Strings converted to Ints:")
    let ints = s_array.apply_function[Int, make_string_array_ints]()
    for i in range(3):
        print(ints[i])
    
    print("\nInts + 2:")
    let added = ints.apply_function[Int, add_two]()
    for i in range(3):
        print(added[i])
