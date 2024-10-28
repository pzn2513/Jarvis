#Requires AutoHotkey v2.0
if ( not A_IsAdmin) {
  try {
    Run "*RunAs " A_ScriptFullPath  ; 以管理员权限重新运行脚本
  }
  catch {
    MsgBox "An error occurred while attempting to run the script as an administrator."
    return
  }
  ExitApp  ; 退出当前的非管理员实例
}
; #NoTrayIcon
#include "basic_error.ahk"
#include "basic_win.ahk"
#include "basic_tool.ahk"
#include "basic_comm.ahk"
SetNumLockState "AlwaysOn" ; 锁定NumLock状态
DetectHiddenWindows True
; InstallKeybdHook
; InstallMouseHook ;检测不到罗技鼠标更多的按键
; KeyHistory 500
^ESC:: ExitApp()
^+AppsKey:: Reload()
#HotIf WinActive('ahk ahk_class Chrome_WidgetWin_1')
~^s:: Reload()
#HotIf
^+!s:: Reload() ;ctrl+shift+alt+d Reload
^+!a:: Pause -1
; ^+!d:: Suspend
~PrintScreen & ScrollLock:: mouse_spy_exe()
^+#Left:: mouse_spy_exe()
; shift+小键盘比较特殊，能用，会改变输入法中英状态，松开时再变回来 | 这按键和&按键远控不行
NumpadIns:: w_hide_show(0) ;+Numpad0
NumpadEnd:: w_move(1) ;+Numpad1
NumpadDown:: w_move(2) ;+Numpad2
NumpadPgdn:: w_move(3) ;+Numpad3


; PgDn & Numpad0:: tip("PgDn热键，拦截原功能，只做热键触发器")
; PgDn & Numpad4:: pgdn4
; PgDn & Numpad5:: pgdn5
; PgDn & Numpad6:: pgdn6
; PgDn & Numpad7:: pgdn7
; PgDn & Numpad8:: pgdn8
~Pause & Numpad0:: tip("Pause热键，未拦截原功能，做热键触发器")
ScrollLock & Numpad0:: tip("ScrollLock热键，拦截原功能，只做热键触发器")
PrintScreen & Numpad0:: tip("PrintScreen热键，拦截原功能，只做热键触发器")
Insert & Numpad0:: tip("Insert热键，拦截原功能，只做热键触发器")


pgdn4() {
  w_top_toggle()
}
pgdn5() {
  tip ontop_GUIs
}
pgdn6() {
  tip "pgdn6"
}
pgdn7() {
  tip "pgdn7"
}
pgdn8() {
  tip "pgdn8"
}