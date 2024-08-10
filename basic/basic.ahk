#Requires AutoHotkey v2.0
; #NoTrayIcon
#include "basic_error.ahk"
#include "basic_spy.ahk"
#include "basic_tool.ahk"
#include "basic_comm.ahk"
SetNumLockState "AlwaysOn" ; 锁定NumLock状态
DetectHiddenWindows True
InstallKeybdHook
InstallMouseHook ;检测不到罗技鼠标更多的按键
KeyHistory 500
^ESC::ExitApp()
#HotIf GetKeyState("s", "P") ;ctrl+s+d Reload
^d::Reload()
#HotIf
~PrintScreen & ScrollLock::mouse_spy_exe()
; shift+小键盘比较特殊，能用，会改变输入法中英状态，松开时再变回来
NumpadIns::w_hide_show(0) ;+Numpad0
NumpadEnd::w_move(1) ;+Numpad1
NumpadDown::w_move(2) ;+Numpad2
NumpadPgdn::w_move(3) ;+Numpad3
NumpadLeft::help原神() ;+Numpad4
NumpadClear::help星铁() ;+Numpad5
NumpadRight::tip(6) ;+Numpad6
NumpadHome::tip(7) ;+Numpad7
NumpadUp::tip(8) ;+Numpad8
NumpadPgUp::tip(9) ;+Numpad9
PgDn & Numpad0::tip("PgDn热键，拦截原功能，只做热键触发器")
PgDn & Numpad4::pgdn4
PgDn & Numpad5::pgdn5
PgDn & Numpad6::pgdn6
PgDn & Numpad7::pgdn7
PgDn & Numpad8::pgdn8
~Pause & Numpad0::tip("Pause热键，未拦截原功能，做热键触发器")
ScrollLock & Numpad0::tip("ScrollLock热键，拦截原功能，只做热键触发器")
PrintScreen & Numpad0::tip("PrintScreen热键，拦截原功能，只做热键触发器")
Insert & Numpad0::tip("Insert热键，拦截原功能，只做热键触发器")

pgdn4(){
    tip hide_ids
}
pgdn5(){
    clr := {}
    for n, component in ["red", "green", "blue"]
        clr.%component% := Random(0, 255)
    MsgBox clr.red "," clr.green "," clr.blue
}
pgdn6(){
    block_send()
}
pgdn7(){
    comm_write("通过comm与其他程序通信")
}
pgdn8(){
    tip comm_read()
}
block_send(){
    ; ctrl+alt+del可解除
    mouse_spy()
    tip mX " " mY " " wId " "
    BlockInput true
    WinActivate "原神 ahk_class UnityWndClass"
    sendstd "LBUTTON"
    WinActivate wId
    click mX,mY,0
    BlockInput false
}
block_click(x,y){
    ; ctrl+alt+del可解除
    mouse_spy(0)
    ; tip mX " " mY " " wId " "
    BlockInput true
    MouseMove x,y,0
    sendstd "LBUTTON"
    ; sendstd "LBUTTON",10,10
    WinActivate wId
    MouseMove mX,mY,0
    BlockInput false
}
