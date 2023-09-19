from python import Python


# Handle errors so caller doesn't need to
fn test1():
    try:
        let np = Python.import_module("numpy")
        print(np.array([1, 2, 3]))
    except e:
        print("Error importing and using numpy:", e.value)


# Doesn't handle errors, but caller will need to
fn test2() raises:
    let np = Python.import_module("numpy")
    print(np.array([1, 2, 3]))


# Doesn't need raises because `def` expects that it could raise
# Caller still needs to handle error
def test3():
    let np = Python.import_module("numpy")
    print(np.array([1, 2, 3]))


fn main():
    let a = test1()
    # These two would cause an error unless you put them in try/catch blocks or change `fn main()` to raises
    # let b = test2()
    # let c = test3()
