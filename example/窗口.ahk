DetectHiddenWindows True
^ESC::ExitApp()
~^s::Reload()
^1::w_move(1)
^2::w_move(2)
^3::w_move(3)
^Numpad1::WinHide(hwnd)
^Numpad2::WinShow(hwnd)
WinTitle:= "绝区零"
hwnd := WinExist(WinTitle)
if(hwnd=0){
    ; MsgBox("hwnd: " hwnd "！没找到窗口: " WinTitle)
}
; 获取WinExist 移动WinMove WinHide置顶WinActive 
w_move(num) {
    global client_x
    while(client_x>1920*num-200){
        client_x-=1920
    }
    while(client_x<1920*num-1920-200){
        client_x+=1920
    }
    WinMove client_x,client_y,client_width,client_height,hwnd
}
Toggle := false
CoordMode_RelativeTo:= "Client" ; Screen , Window , Client(default)

F1::win_spy()
Hk_changeCoord(ThisHotkey){
    if(CoordMode_RelativeTo="Client"){
        global CoordMode_RelativeTo:= "Screen"
    }else{
        global CoordMode_RelativeTo:= "Client"
    }       
}
Hk_save(hk){
    ; TrayTip(hk, text)
    A_Clipboard := text
    win_spy()
}
win_spy(){
    global Toggle := !Toggle ;Toggle的值是可读的，但要修改必须使用global关键字；否则会被AHK认为是局部变量，在表达式中声明未赋值的同时使用就会出错。
    if (Toggle) {
        SetTimer(WatchMouse, 100)
        Hotkey("alt",Hk_changeCoord,"On")
        Hotkey("*RButton up",Hk_save,"On")
    } else {
        SetTimer(WatchMouse, 0)
        ToolTip
        Hotkey("alt",,"Off")
        Hotkey("*RButton up",,"Off")
    }
}
WatchMouse(RelativeTo := "Client") {
    ; CoordMode不使用默认就是Client，适合大多数情况
    CoordMode("Mouse", CoordMode_RelativeTo)
    CoordMode("ToolTip", CoordMode_RelativeTo)
    CoordMode("Pixel", CoordMode_RelativeTo)
    global hwnd,client_x,client_y,client_width,client_height
    MouseGetPos(&MouseX, &MouseY, &hwnd)
    Color := PixelGetColor(MouseX, MouseY, "RGB")
    WinTitle := WinGetTitle(hwnd)
    WinClass := WinGetClass(hwnd)
    WinGetPos(&client_x, &client_y, &client_width, &client_height, hwnd)
    ProcessName := WinGetProcessName(hwnd)
    ProcessPath := WinGetProcessPath(hwnd)
    global text
    text := "坐标: (" MouseX ", " MouseY ")    ALT转换坐标系,当前:" CoordMode_RelativeTo "`n"
    . "颜色: " Color "`n" 
    . "句柄: " hwnd "`n"
    . "窗口名: " WinTitle "`n"
    . "窗口类: " WinClass "`n"
    . "位置: (" client_x ", " client_y ") - (" client_width ", " client_height ")`n"
    . "进程名: " ProcessName "`n"
    . "路径: " ProcessPath "`n"
    lines := 8
    if(ProcessName!="AutoHotkey64.exe"){
        if(MouseY>1000-18*lines){ ; 根据行数动态调整
            Tooltip(text, MouseX+15, MouseY-15-18*lines)
        }else{
            Tooltip(text, MouseX+30, MouseY+30)
        }
    }else{
        Tooltip()
    }
}
; F1:: {
;     SetTimer(WatchMouse, 50)
;     return
; }


