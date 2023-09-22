from python import Python
from time import sleep

fn button_clicked():
    print("Hello Mojo🔥!")

fn exit(status: Int32) -> UInt8:
    return external_call["exit", UInt8, Int32](status)


def main():
    Python.add_to_path(".")
    var ctk = Python.import_module("customtkinter")
    # let interface = Python.import_module("interface")
    let app = ctk.CTk()

    ctk.set_appearance_mode("System")
    ctk.set_default_color_theme("blue")
    app.geometry("800x600")
    var button = interface.create_button(app, "Hello Mojo!")
    button = customtkinter.CTkButton(
        master=app, text=button_text,
    )
    button.pack()
    while True:
        app.update()
        if button.is_button_pressed():
            button_clicked()
