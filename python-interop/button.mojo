from python import Python
from time import sleep

#xrandr --output eDP-1 --off --output HDMI-1 --auto
# from lasso.dyna import D3plot, ArrayType, FilterType
#mojo build g3.mojo in the folder 


fn load_data(path: StringLiteral):
    try:
        let time =  Python.import_module("time")
        let lass =  Python.import_module("lasso.dyna")
        

        print("printing from load data function",path)

        let start_time = time.time()
        let loaded_file = lass.D3plot(path)
        let keyval = loaded_file.arrays.keys        
        let pstrain = loaded_file.arrays[lass.ArrayType.element_shell_effective_plastic_strain]


        # mean across all 3 integration points
        let pstrain_m = pstrain.mean(2)


        # we only have 1 timestep here but let's take last one in general
        let last_timestep = -1
        let fringe_limits=(0, 0.3)
        let plotted=loaded_file.plot(0, pstrain_m[last_timestep], True,fringe_limits)
        let end_time = time.time()
        let elapsed_time = end_time - start_time
        print(elapsed_time)

    except:
        print("exception thrown")
        #pass        


fn button_clicked():
    print("fn Button was clicked!")

def py_button_clicked():
    print("def Button was clicked!")

def open_file_explorer() -> String:
    #global selected_file_path
    let tk = Python.import_module("tkinter")
    let filedialog = Python.import_module("tkinter.filedialog") 
    root = tk.Tk()
    root.withdraw()  # Hide the main window
    let selected_file_path = filedialog.askopenfilename()
    print(selected_file_path)
    
     
    var py_instance = Python()
    var mojo_str: StringRef = py_instance.__str__(selected_file_path)
    my_object = selected_file_path  # Your object here
    string_representation = my_object.to_string()
    print("string rep is",string_representation)
    return selected_file_path.to_string()


    return mojo_str

fn exit(status: Int32) -> UInt8:
    return external_call["exit", UInt8, Int32](status)


fn main() raises:
    let imgui =  Python.import_module("imgui")
    # print(imgui)
    let glfw =  Python.import_module("glfw")
    print(glfw)
    let GlfwRenderer = Python.import_module("imgui.integrations.glfw")
    let gl = Python.import_module("OpenGL.GL") 
    let tk = Python.import_module("tkinter")
    let filedialog = Python.import_module("tkinter.filedialog")    
    print("modules imported")
    if not glfw.init():
        return       

    let window = glfw.create_window(640, 480, "Web Result View 0.1", None, None)
    let cont = glfw.make_context_current(window)       
    let context = imgui.create_context()
    let impl = imgui.integrations.glfw.GlfwRenderer(window)
    var  state = "dumb path"
    print("state assigned dumb path outside of loop", state)

    let v_sync_enable =glfw.swap_interval(1)

        while not glfw.window_should_close(window):
            let v1 = glfw.poll_events()
            let v2 = impl.process_inputs()

            let clear_context = glfw.make_context_current(window)
            let color_clear = gl.glClearColor(0.4, 0.4, 0.4, 1)
            let all_clear=gl.glClear(gl.GL_COLOR_BUFFER_BIT)
            let v3 = imgui.new_frame()

            if imgui.begin_main_menu_bar():
                if imgui.begin_menu("File", True):
                    let clicked_exit = imgui.menu_item( "Exit", '', False, True)
                    if clicked_exit:
                        print("exit")
                        _ = exit(0)
                    let end_men =imgui.end_menu()

            let end_menubar=imgui.end_main_menu_bar()
            let begin = imgui.begin("My Window", True)
            
            # Display the button and check if it's pressed
            if imgui.button("select d3plot file"):
                var state = open_file_explorer()
                print("state passed to var from function-now in main")
                print(state)
                print("state printed")

            if imgui.button("Load 3Dyna Results"):
                load_data(state)
                #print(string_representation)

            let end = imgui.end()
            let render=imgui.render()
            let impl_render = impl.render(imgui.get_draw_data())
            let swap_buff = glfw.swap_buffers(window)

        let imp_shutdown=impl.shutdown()
        let terminate = glfw.terminate()
