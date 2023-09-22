struct CharArray:
    var data: Pointer[Int8]
    var size: Int
    var cap: Int

    fn __init__(inout self, size: Int):
        self.cap = size
        self.size = size
        self.data = Pointer[Int8].alloc(self.cap)

    fn __getitem__(self, i: Int) -> Int8:
        return self.data.load(i)

    fn __setitem__(inout self, i: Int, value: Int8):
        self.data.store(i, value)

    fn to_string(self) -> String:
        return String(self.data, self.size)  # Convert to a String

fn toLowercase(owned inputString: String) -> String:
    let length: Int = len(inputString)
    var charArray = CharArray(length)

    for i in range(length):
        let char: String = inputString[i:i+1]
        var asciiValue: Int = ord(char)
        
        if 65 <= asciiValue and asciiValue <= 90:  # A-Z
            asciiValue += 32  # Convert to a-z
        
        charArray[i] = Int8(asciiValue)  # Construct the Int8 value
        
    let lowercaseString: String = charArray.to_string()
    return lowercaseString

fn main():
    let myString: String = "Hello WORLD"
    let lowercasedString: String = toLowercase(myString)
    print(lowercasedString)
