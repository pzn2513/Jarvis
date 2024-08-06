#Requires AutoHotkey v2.0
#include "basic_test.ahk"
DetectHiddenWindows True
InstallKeybdHook
InstallMouseHook ;检测不到罗技鼠标更多的按键
KeyHistory 500
^ESC::ExitApp()
~^s::Reload()
/*
把使用的很少的PrintScreen ScrollLock Pause Insert PgUp PgDn AppsKey利用起来
自立规矩，还可以用#HotIf WinActive("ahk_class Notepad")来限制热键只在特定窗口生效
===basic功能组合按键===
使用顺序：PgDn>PgUp>Pause>ScrollLock>PrintScreen>Insert>
ScrollLock &：用来对窗口操作
Pause &：basic中的各种测试basic_test()
Insert &：
PgUp &：
PgDn &：
PrintScreen &：
===main===
^小键盘：主程序各阶段的运行
+小键盘：各类测试
AppsKey & Numpad0：成熟功能放置
!小键盘：
#小键盘：
===键鼠额外功能键===
Xbutton1
Xbutton2
*/
PgDn & Numpad0::tip("PgDn热键，拦截原功能，只做热键触发器")
; shift+小键盘比较特殊，能用，会改变输入法中英状态，送开时再变回来
NumpadIns::w_hide_show() ;+Numpad0
NumpadEnd::w_move(1) ;+Numpad1
NumpadDown::w_move(2) ;+Numpad2
NumpadPgdn::w_move(3) ;+Numpad3
NumpadLeft::tip(4) ;+Numpad4
NumpadClear::tip(5) ;+Numpad5
NumpadRight::tip(6) ;+Numpad6
NumpadHome::tip(7) ;+Numpad7
NumpadUp::tip(8) ;+Numpad8
NumpadPgUp::tip(9) ;+Numpad9
~Pause & Numpad0::tip("Pause热键，未拦截原功能，做热键触发器")
~Pause & Numpad9::basic_test9()
~Pause & Numpad8::basic_test8()
~Pause & Numpad7::basic_test7()
~Pause & Numpad6::basic_test6()
~Pause & Numpad5::basic_test5()
~Pause & Numpad4::basic_test4()
~Pause & Numpad3::basic_test3()
~Pause & Numpad2::basic_test2()
~Pause & Numpad1::basic_test1()
ScrollLock & Numpad0::tip("ScrollLock热键，拦截原功能，只做热键触发器")
PrintScreen & Numpad0::tip("PrintScreen热键，拦截原功能，只做热键触发器")
Insert & Numpad0::tip("Insert热键，拦截原功能，只做热键触发器")
~PrintScreen & ScrollLock::mouse_spy_exe()

global mX,mY,mColor,wId,wX,wY,wW,wH,wTitle,wClass,wExe,wPath
global cId,cX,cY,cW,cH,cTitle,cClass,cExe,cPath,hide_id
hide_id:=""

; 定义系统光标常量
IDC_ARROW := 32512
IDC_CROSS := 32515

; 按下 Win+C 键时切换光标
#c::SystemCursor("Toggle")

; 确保脚本退出时光标恢复为箭头
OnExit(*) => SystemCursor("Show")

SystemCursor(cmd)  ; cmd = "Show|Hide|Toggle|Reload"
{
    static visible := true, c := Map()
    static sys_cursors := [32512, 32513, 32514, 32515, 32516, 32642
                         , 32643, 32644, 32645, 32646, 32648, 32649, 32650]
    
    if (cmd = "Reload" or !c.Count)  ; 在请求或首次调用时进行重载.
    {
        for i, id in sys_cursors
        {
            h_cursor  := DllCall("LoadCursor", "Ptr", 0, "Ptr", id)
            h_default := DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2
                , "Int", 0, "Int", 0, "UInt", 0)
            c[id] := {default: h_default}
        }
        ; 加载十字光标并创建其副本
        h_cursor  := DllCall("LoadCursor", "Ptr", 0, "Int", IDC_CROSS)
        h_cross := DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2
            , "Int", 0, "Int", 0, "UInt", 0)
    }
    
    switch cmd
    {
      case "Show": visible := true
      case "Hide": visible := false
      case "Toggle": visible := !visible
      default: return
    }
    
    for id, handles in c
    {
        h_cursor := DllCall("CopyImage"
            , "Ptr", visible ? handles.default : h_cross
            , "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
        DllCall("SetSystemCursor", "Ptr", h_cursor, "UInt", id)
    }
}

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
    tip cX
    while(cX>1920*num-200){
        cX-=1920
    }
    while(cX<1920*num-1920-200){
        cX+=1920
    }
    WinMove cX,cY,cW,cH,cId
}
mouse_spy_bool := false
CoordMode_RelativeTo:= "Client" ; Screen , Window , Client(default)
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

/*
一些工具函数
*/
func_select(arr,keep_appear_times:=1){
    ; 传入二维数组arr,[[判断函数，执行函数],...]
    reset_arr:=CreateZeroArray(arr.Length)
    count_arr:=reset_arr
    loop{
        for k,v in arr{
            if(v[1]()){
                if(count_arr[k]==0){
                    count_arr:=reset_arr
                    count_arr[k]:=count_arr[k]+1
                }else{
                    count_arr[k]:=count_arr[k]+1
                }
                if(count_arr[k]>=keep_appear_times){
                    tip "func_select执行: " k
                    if(v.Has(2)){
                        tip "1 :" v.Has(2)
                        v[2]() 
                    }else{
                        tip "0 :" v.Has(2)
                    }
                    return k
                }
            }
        }
        sleep 100
    }
}
CreateZeroArray(num) {
    zeroArray := []
    loop num {
        zeroArray.Push(0)
    }
    return zeroArray
}
getpix(x,y,color,similar:=0){
    PixelSearch &fx, &fy, x, y, x, y, color, similar
    if(fx!=""){
        return [x,y,color]
    }else{
        return
    }
}
mgetpix(arr){
    ; arr:=[[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]]
    ; arr:=[[1320,884,0x222022,6], [2344,888,0x672337,6]]
    find:=[]
    for k,v in arr{
        PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
        if(fx!=""){
            find.push(v)
        }
    }
    if(find.length==arr.length){
        return find
    }else{
        return
    }
}
waitpix(x,y,color,similar:=0,appear_times:=1,function:=()=>{},interval:=100,timeout:=0){
    StartTime := A_TickCount
    num:=0
    loop{
        PixelSearch &fx, &fy, x, y, x, y, color, similar
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(fx!=""){
                num++
                if(num>=appear_times){
                    ; tip "waitpix ok,appear_times:" num
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(fx==""){
                num--
                if(num<=appear_times){
                    ; tip "waitpix ok,appear_times:" num
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }
        function()
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            return "timeout"
        }
    }
}
; waitpix如果容易误判的，就用mwaitpix加多几个pix增强可信度
mwaitpix(arr,correct_offset:=0,appear_times:=1,function:=()=>{},interval:=100){
    ; arr:=[[x,y,color,similar],...]
    num:=0
    loop{
        correct:=[]
        for k,v in arr{
            if(!v.Has(4)){
                v.push(0)
            }
            PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
            if(fx!=""){
                correct.Push(v)
            }
        }
        tip "correct: " correct.Length
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(correct.Length>=arr.length-correct_offset){
                num++
                if(num>=appear_times){
                    return correct
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(correct.Length<arr.length-correct_offset){
                num--
                if(num<=appear_times){
                    return correct
                }
            }else{
                num:=0
            }
        }
        function()
        sleep interval
    }
}
sendstd(key,delay:=150,keeppress:=30){
    send "{" key " Down}"
    sleep keeppress
    send "{" key " Up}"
    sleep delay
}
printarr_2d(arr:=[["hello","world"],["this is printarr_2d","default"]]){
    if(!IsArr(arr)){
        msgbox_autoclose "is not array"
        return
    }
    output:= ""
    for k,v in arr{
        if(IsArr(v)){
            for k1,v1 in v{
                output .= v1 ","
            }
            output .= "`n"            
        }else{
            output .= v ","
        }
    }
    msgbox_autoclose output
}
IsArr(var) {
    return IsObject(var) && var.HasProp("Length")
}

msgbox_autoclose(msg,delay:=1000){
    SetTimer(() => WinClose("ahk_class #32770"), -delay)
    MsgBox msg
}
tip(message,delay:=3000){
    ToolTip message
    SetTimer ()=>ToolTip(),-delay
}