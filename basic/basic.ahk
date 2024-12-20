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
SetStartup() ; 在脚本开始时调用开机启动设置函数
SetStartup()
{
  startupFolder := A_Startup
  scriptPath := A_ScriptFullPath
  scriptName := A_ScriptName
  shortcutPath := startupFolder "\" StrReplace(scriptName, ".ahk", ".lnk")
  if !FileExist(shortcutPath)
  {
    FileCreateShortcut(scriptPath, shortcutPath)
    MsgBox("已将脚本添加到开机启动项。")
  }
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
; ^+!a:: Pause -1
; ^+!d:: Suspend




