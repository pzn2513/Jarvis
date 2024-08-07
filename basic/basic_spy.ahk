global mX,mY,mColor,wId,wX,wY,wW,wH,wTitle,wClass,wExe,wPath
global cId,cX,cY,cW,cH,cTitle,cClass,cExe,cPath,hide_id
hide_id:=""
mouse_spy_bool := false
CoordMode_RelativeTo:= "Client" ; Screen , Window , Client(default)
w_hide_show(){
    global hide_id
    if(hide_id){
        WinShow(hide_id)
        hide_id:=""
    }else{
        client_spy()
        WinHide(cId)
        hide_id:=cId    
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
        Hotkey("RButton up",mspy_saveClipboard,"On")
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
        Hotkey("RButton up",mspy_saveClipboard,"Off")
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
mouse_spy(RelativeTo := "Client") {
    ; CoordMode不使用默认就是Client，适合大多数情况
    CoordMode("Mouse", CoordMode_RelativeTo)
    ; CoordMode("ToolTip", CoordMode_RelativeTo)
    CoordMode("Pixel", CoordMode_RelativeTo)
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