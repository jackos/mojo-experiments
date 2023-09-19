from python import Python


def main():
    let sys = Python.import_module("sys")
    let print = Python.import_module("pprint").pprint
    print(sys.path)

    Python.add_to_path(".")
    let fractal = Python.import_module("fractal")
    fractal.run("Hi Mojo!")
    # fractal.run("Wow")
