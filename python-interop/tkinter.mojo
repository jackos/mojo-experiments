from python import Python

def main():
    Python.add_to_path(".")
    let interface = Python.import_module("interface")
    interface.create("800x600", "Hello Mojo")
