import customtkinter

app = customtkinter.CTk()


def button_function():
    print("Hello Mojo, from Python")


def create(resolution: str, button_text: str):
    customtkinter.set_appearance_mode("System")
    customtkinter.set_default_color_theme("blue")
    app.geometry(resolution)
    button = customtkinter.CTkButton(
        master=app, text=button_text, command=button_function
    )
    button.place(relx=0.5, rely=0.5, anchor=customtkinter.CENTER)
    app.mainloop()
