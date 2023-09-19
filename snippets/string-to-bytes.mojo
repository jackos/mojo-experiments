from builtin.string import ord


fn main():
    let s = String("Mojo!")
    let b = s._buffer
    for i in range(len(b)):
        print(b[i])
    _ = s
