from python import Python

fn button_clicked():
    print("Hi from a Mojo🔥 fn!")

def main():
    Python.add_to_path(".")
    let interface = Python.import_module("interface")
    interface.create("800x600")
    let app = interface.app
    let button = interface.create_button("Hello Mojo!")

    while True:
        app.update()
        if interface.clicked:
            button_clicked()
            interface.clicked = False
