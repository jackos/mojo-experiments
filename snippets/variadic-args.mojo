fn print_vals[T: DType](*values: Int) -> None:
    for i in range(3):
        print(values[i])


fn main():
    print_vals[DType.int64](10, 20, 30)
