import customtkinter as ctk

app = ctk.CTk()
clicked = False


def click():
    global clicked
    clicked = True


def create(res: str):
    ctk.set_appearance_mode("System")
    ctk.set_default_color_theme("blue")
    app.geometry(res)


def create_button(button_text: str):
    button = ctk.CTkButton(
        master=app,
        text=button_text,
        command=click
    )
    button.place(relx=0.5, rely=0.5, anchor=ctk.CENTER)
    return button
