/************************************************************************
 * @file basic_win.ahk
 * @author Ghini
 * @description 窗口相关操作
 * 窗口检测，隐藏，移动，置顶等
 ***********************************************************************/


global mX,mY,mColor,wId,wX,wY,wW,wH,wTitle,wClass,wExe,wPath ;鼠标获取的
global cId,cX,cY,cW,cH,cTitle,cClass,cExe,cPath,hide_id ;当前客户端（激活窗口)获取的
hide_id:=""
mouse_spy_bool := false
CoordMode_RelativeTo:= "Client" ; Screen , Window , Client(default)
hide_ids:={}
w_hide_show(signal){
    global hide_ids
    if(hide_ids.HasProp(signal)){
        WinShow(hide_ids.%signal%)
        hide_ids.DeleteProp(signal)
    }else{
        client_spy()
        hide_ids.%signal%:=cId 
        WinHide(cId)
    }
}
w_move(num) {
    client_spy()
    global cX
    while(cX>1920*num-200){
        cX-=1920
    }
    while(cX<1920*num-1920-200){
        cX+=1920
    }
    WinMove cX,cY,cW,cH,cId
}
mouse_spy_exe(){
    global mouse_spy_bool := !mouse_spy_bool ;mouse_spy_bool的值是可读的，但要修改必须使用global关键字；否则会被AHK认为是局部变量，在表达式中声明未赋值的同时使用就会出错。
    if (mouse_spy_bool) {
        SetTimer(mouse_spy, 100)
        ; Hotkey("alt",mspy_changeCoord,"On")
        ; Hotkey("alt up",mspy_changeCoord,"On")
        ; Hotkey("*RButton up",mspy_saveClipboard,"On") ;鼠标右键按下可能会移动鼠标造成误差
        Hotkey("*Numpad0 Up",mspy_saveClipboard,"On")
        Hotkey("*RButton Up",mspy_saveClipboard,"On")
        Hotkey("Up",mspy_up,"On")
        Hotkey("Down",mspy_down,"On")
        Hotkey("Right",mspy_right,"On")
        Hotkey("Left",mspy_left,"On")
        Hotkey("^Up",mspy_up_fast,"On")
        Hotkey("^Down",mspy_down_fast,"On")
        Hotkey("^Right",mspy_right_fast,"On")
        Hotkey("^Left",mspy_left_fast,"On")
    } else {
        SetTimer(mouse_spy, 0)
        ToolTip
        ; Hotkey("alt",mspy_changeCoord,"Off")
        ; Hotkey("alt up",mspy_changeCoord,"Off")
        ; Hotkey("*RButton up",mspy_saveClipboard,"Off")
        Hotkey("*Numpad0 Up",mspy_saveClipboard,"Off")
        Hotkey("*RButton Up",mspy_saveClipboard,"Off")
        Hotkey("Up",mspy_up,"Off")
        Hotkey("Down",mspy_down,"Off")
        Hotkey("Right",mspy_right,"Off")
        Hotkey("Left",mspy_left,"Off")
        Hotkey("^Up",mspy_up_fast,"Off")
        Hotkey("^Down",mspy_down_fast,"Off")
        Hotkey("^Right",mspy_right_fast,"Off")
        Hotkey("^Left",mspy_left_fast,"Off")
    }
}
mspy_up(ThisHotkey){
    click mX,mY-1,0
}
mspy_down(ThisHotkey){
    click mX,mY+1,0
}
mspy_right(ThisHotkey){
    click mX+1,mY,0
}
mspy_left(ThisHotkey){
    click mX-1,mY,0
}
mspy_up_fast(ThisHotkey){
    click mX,mY-10,0
}
mspy_down_fast(ThisHotkey){
    click mX,mY+10,0
}
mspy_right_fast(ThisHotkey){
    click mX+10,mY,0
}
mspy_left_fast(ThisHotkey){
    click mX-10,mY,0
}
mspy_changeCoord(ThisHotkey){
    if(CoordMode_RelativeTo="Client"){
        global CoordMode_RelativeTo:= "Screen"
    }else{
        global CoordMode_RelativeTo:= "Client"
    }       
}
mspy_saveClipboard(ThisHotkey){
    A_Clipboard := mX "," mY "," mColor
    mouse_spy_exe()
}
mouse_spy(dotip:=true,RelativeTo := "Client") {
    ; CoordMode不使用默认就是Client，适合大多数情况
    ; CoordMode("Mouse", CoordMode_RelativeTo)
    ; CoordMode("ToolTip", CoordMode_RelativeTo)
    ; CoordMode("Pixel", CoordMode_RelativeTo)
    global mX,mY,mColor,wId,wX,wY,wW,wH,wTitle,wClass,wExe,wPath
    MouseGetPos(&mX, &mY, &wId)
    mColor := PixelGetColor(mX, mY, "RGB")
    wTitle := WinGetTitle(wId)
    wClass := WinGetClass(wId)
    WinGetPos(&wX, &wY, &wW, &wH, wId)
    wExe := WinGetProcessName(wId)
    wPath := WinGetProcessPath(wId)
    global text
    text := "坐标: (" mX ", " mY ")    激活窗口的坐标系,当前:" CoordMode_RelativeTo "`n"
    . "颜色: " mColor "`n" 
    . "句柄: " wId "`n"
    . "窗口名: " wTitle "`n"
    . "窗口类: " wClass "`n"
    . "位置: (" wX ", " wY ") - (" wW ", " wH ")`n"
    . "进程名: " wExe "`n"
    . "路径: " wPath "`n"
    lines := 8
    if !dotip
        return
    if(wExe!="AutoHotkey64.exe"){
        if(mY+wY>1000-18*lines){ ; 根据行数动态调整
            Tooltip(text, mX+15, mY-15-18*lines)
        }else{
            Tooltip(text, mX+30, mY+30)
        }
    }else{
        Tooltip()
    }
}
client_spy(title:="A"){
    ; 获取当前窗口信息，tip显示
    global cId,cX,cY,cW,cH,cTitle,cClass,cExe,cPath
    cId:=WinGetID(title)
    cTitle:=WinGetTitle(cId)
    cClass:=WinGetClass(cId)
    WinGetPos(&cX, &cY, &cW, &cH, cId)
    cExe:=WinGetProcessName(cId)
    cPath:=WinGetProcessPath(cId)
    text := "句柄: " cId "`n"
    . "窗口名: " cTitle "`n"
    . "窗口类: " cClass "`n"
    . "位置: (" cX ", " cY ") - (" cW ", " cH ")`n"
    . "进程名: " cExe "`n"
    . "路径: " cPath "`n"
    ; tip(text)
}
global ontop_GUIs := {}
w_top_toggle() {
    ; 创建红点 GUI
    hwnd := WinExist("A")
    ; 未置顶则置顶，已置顶则取消状态
    if ((WinGetExStyle(hwnd) & 0x8) == 0) { ;0x8 窗口置顶的位掩码（Bitmask）
        WinSetAlwaysOnTop 1, hwnd
        ontop_GUIs.%hwnd% := Gui("+AlwaysOnTop -Caption +ToolWindow")
        ontop_GUIs.%hwnd%.BackColor := "Red"
        ontop_GUIs.%hwnd%.Opt("+E0x20")  ; 点击穿透
        ; 获取活动窗口信息并定位红点
        ontop_GUIs.%hwnd%.timer := () => PositionDot(ontop_GUIs.%hwnd%)
        SetTimer(ontop_GUIs.%hwnd%.timer, 10)
    } else {
        WinSetAlwaysOnTop 0, hwnd
        if (ontop_GUIs.HasOwnProp(hwnd)) {
            SetTimer(ontop_GUIs.%hwnd%.timer, 0)
            ontop_GUIs.%hwnd%.Destroy()
            ontop_GUIs.DeleteProp(hwnd)
        }
    }
    PositionDot(GUI) {
        ; 窗口是激活的渲染显示，没激活不用管。
        if (WinActive(hwnd)) {
            WinGetPos(&actX, &actY, &actW, &actH, hwnd)
            GUI.Show(Format("x{} y{} w8 h8 NoActivate", actX + actW - 15, actY + 0))
            WinSetAlwaysOnTop 1, GUI.Hwnd
        }
    }
}