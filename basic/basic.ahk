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
        Hotkey("alt",mspy_changeCoord,"On")
        Hotkey("alt up",mspy_changeCoord,"On")
        Hotkey("*RButton up",mspy_saveClipboard,"On")
    } else {
        SetTimer(mouse_spy, 0)
        ToolTip
        Hotkey("alt",mspy_changeCoord,"Off")
        Hotkey("alt up",mspy_changeCoord,"Off")
        Hotkey("*RButton up",mspy_saveClipboard,"Off")
    }
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
    CoordMode("ToolTip", CoordMode_RelativeTo)
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
    text := "坐标: (" mX ", " mY ")    ALT转换坐标系,当前:" CoordMode_RelativeTo "`n"
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
            Tooltip(text, mX+15, mY+wY-15-18*lines)
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
waitpix(x,y,color,similar:=0,appear_times:=1,function:=()=>{},interval:=100){
    num:=0
    loop{
        PixelSearch &fx, &fy, x, y, x, y, color, similar
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(fx!=""){
                num++
                if(num>=appear_times){
                    ; Tip fx "," fy
                    break
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(fx==""){
                num--
                if(num<=appear_times){
                    ; Tip fx "," fy
                    break
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