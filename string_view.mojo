struct StringView[dtype: DType, lifetime: ImmLifetime]:
    """Create an unowned immutable view to a String using any dtype."""
    var size: Int
    var ref: Reference[SIMD[dtype], False, lifetime]

    fn __init__(inout self, x: Reference[String, False, lifetime]):
        debug_assert(len(x[]) // sizeof[dtype]() > 0, "String not large enough")
        self.size = len(x[]) // sizeof[dtype]()
        self.ref = x[].unsafe_ptr().bitcast[SIMD[dtype]]()[]

    fn __len__(self) -> Int:
        return self.size

    fn __getitem__(self, index: Int) -> Scalar[dtype]:
        debug_assert(index < len(self), "index out of bounds")
        return self.ref[][index]


fn printer(s: StringView):
    for i in range(len(s)):
        print(s[i])


fn main():
    print(sizeof[DType.uint32]())
    var s = String("Mojo")
    var view = StringView[DType.uint32](s)
    printer(view)
