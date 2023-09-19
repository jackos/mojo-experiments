from python import Python

fn print_time() raises:
    let time = Python.import_module("time") # like this
    let current_time = time.strftime('%H:%M:%S')
    print("Current time:", current_time)

def print_time_def():
    time = Python.import_module("time") # like this
    current_time = time.strftime('%H:%M:%S')
    print("Current time:", current_time)

fn main() raises:
    _ = print_time_def()
    print_time()
