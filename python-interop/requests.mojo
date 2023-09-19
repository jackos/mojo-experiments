from python import Python


fn main() raises:
    Python.add_to_path(".env/lib/python3.11/site-packages")
    let requests = Python.import_module("requests")
    print(requests)
