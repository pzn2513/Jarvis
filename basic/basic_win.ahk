/************************************************************************
 * @file basic_win.ahk
 * @author Ghini
 * @description 窗口相关操作
 * 窗口检测，隐藏，移动，置顶等
 * 开机启动
 ***********************************************************************/


global mX, mY, mColor, wId, wX, wY, wW, wH, wTitle, wClass, wExe, wPath ;鼠标获取的
global cId, cX, cY, cW, cH, cTitle, cClass, cExe, cPath, hide_id ;当前客户端（激活窗口)获取的
hide_id := ""
mouse_spy_bool := false
CoordMode_RelativeTo := "Client" ; Screen , Window , Client(default)
hide_ids := {}


; 开机启动,检查并启动程序
startrun(exePath) {
  SplitPath(exePath, &processName)
  try {
      if !ProcessExist(processName) {
          Run exePath
          ; 可选：等待程序启动
          ; WinWait "程序窗口标题"
          return true
      }
  } catch as err {
      MsgBox "启动失败: " err.Message "，路径: " exePath
  }
}
w_hide_show(signal) {
  global hide_ids
  if (hide_ids.HasProp(signal)) {
    WinShow(hide_ids.%signal%)
    hide_ids.DeleteProp(signal)
  } else {
    client_spy()
    hide_ids.%signal% := cId
    WinHide(cId)
  }
}
w_move(num) {
  client_spy()
  global cX
  while (cX > 1920 * num - 200) {
    cX -= 1920
  }
  while (cX < 1920 * num - 1920 - 200) {
    cX += 1920
  }
  WinMove cX, cY, cW, cH, cId
}
mouse_spy_exe() {
  global mouse_spy_bool := !mouse_spy_bool ;mouse_spy_bool的值是可读的，但要修改必须使用global关键字；否则会被AHK认为是局部变量，在表达式中声明未赋值的同时使用就会出错。
  if (mouse_spy_bool) {
    SetTimer(mouse_spy, 100)
    Hotkey("Tab Up", mspy_changeCoord, "On")
    ; Hotkey("alt up",mspy_changeCoord,"On")
    ; Hotkey("*RButton up",mspy_savePos,"On") ;鼠标右键按下可能会移动鼠标造成误差
    Hotkey("*F1 Up", mspy_savePos, "On")
    Hotkey("*F2 Up", mspy_savePath, "On")
    Hotkey("*F3 Up", mspy_saveClass, "On")
    Hotkey("*F4 Up", mspy_saveColor, "On")
    Hotkey("*Numpad0 Up", mspy_savePos, "On")
    Hotkey("*Numpad1 Up", mspy_savePath, "On")
    Hotkey("*Numpad2 Up", mspy_saveClass, "On")
    Hotkey("*Numpad3 Up", mspy_saveColor, "On")
    Hotkey("*RButton Up", mspy_savePos, "On")
    Hotkey("Up", mspy_up, "On")
    Hotkey("Down", mspy_down, "On")
    Hotkey("Right", mspy_right, "On")
    Hotkey("Left", mspy_left, "On")
    Hotkey("^Up", mspy_up_fast, "On")
    Hotkey("^Down", mspy_down_fast, "On")
    Hotkey("^Right", mspy_right_fast, "On")
    Hotkey("^Left", mspy_left_fast, "On")
  } else {
    SetTimer(mouse_spy, 0)
    ToolTip
    Hotkey("Tab Up", mspy_changeCoord, "Off")
    ; Hotkey("alt up",mspy_changeCoord,"Off")
    ; Hotkey("*RButton up",mspy_savePos,"Off")
    Hotkey("*F1 Up", mspy_savePos, "Off")
    Hotkey("*F2 Up", mspy_savePath, "Off")
    Hotkey("*F3 Up", mspy_saveClass, "Off")
    Hotkey("*F4 Up", mspy_saveColor, "Off")
    Hotkey("*Numpad0 Up", mspy_savePos, "Off")
    Hotkey("*Numpad1 Up", mspy_savePath, "Off")
    Hotkey("*Numpad2 Up", mspy_saveClass, "Off")
    Hotkey("*Numpad3 Up", mspy_saveColor, "Off")
    Hotkey("*RButton Up", mspy_savePos, "Off")
    Hotkey("Up", mspy_up, "Off")
    Hotkey("Down", mspy_down, "Off")
    Hotkey("Right", mspy_right, "Off")
    Hotkey("Left", mspy_left, "Off")
    Hotkey("^Up", mspy_up_fast, "Off")
    Hotkey("^Down", mspy_down_fast, "Off")
    Hotkey("^Right", mspy_right_fast, "Off")
    Hotkey("^Left", mspy_left_fast, "Off")
  }
}
mspy_up(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX, mY - 1, 0
}
mspy_down(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX, mY + 1, 0
}
mspy_right(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX + 1, mY, 0
}
mspy_left(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX - 1, mY, 0
}
mspy_up_fast(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX, mY - 10, 0
}
mspy_down_fast(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX, mY + 10, 0
}
mspy_right_fast(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX + 10, mY, 0
}
mspy_left_fast(ThisHotkey) {
  A_CoordModeToolTip := CoordMode_RelativeTo
  A_CoordModePixel := CoordMode_RelativeTo
  A_CoordModeMouse := CoordMode_RelativeTo
  click mX - 10, mY, 0
}
mspy_changeCoord(ThisHotkey) {
  if (CoordMode_RelativeTo = "Client") {
    global CoordMode_RelativeTo := "Screen"
  } else {
    global CoordMode_RelativeTo := "Client"
  }
}
mspy_savePos(ThisHotkey) {
  A_Clipboard := mX "," mY "," mColor
  mouse_spy_exe()
}
mspy_savePath(ThisHotkey) {
  A_Clipboard := wPath
  mouse_spy_exe()
}
mspy_saveClass(ThisHotkey) {
  A_Clipboard := wClass
  mouse_spy_exe()
}
mspy_saveColor(ThisHotkey) {
  A_Clipboard := StrReplace(mColor, "0x", "#")
  mouse_spy_exe()
}
mouse_spy(dotip := true, mode := false) {
  ; CoordMode不使用默认就是Client，适合大多数情况
  if (mode) {
    A_CoordModeToolTip := mode
    A_CoordModePixel := mode
    A_CoordModeMouse := mode
  } else {
    A_CoordModeToolTip := CoordMode_RelativeTo
    A_CoordModePixel := CoordMode_RelativeTo
    A_CoordModeMouse := CoordMode_RelativeTo
  }
  global mX, mY, mColor, wId, wX, wY, wW, wH, wTitle, wClass, wExe, wPath
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
  if (wExe != "AutoHotkey64.exe") {
    if (mY + wY > 1000 - 18 * lines) { ; 根据行数动态调整
      Tooltip(text, mX + 15, mY - 15 - 18 * lines)
    } else {
      Tooltip(text, mX + 30, mY + 30)
    }
  } else {
    Tooltip()
  }
}
client_spy(title := "A") {
  ; 获取当前窗口信息，tip显示
  global cId, cX, cY, cW, cH, cTitle, cClass, cExe, cPath
  cId := WinGetID(title)
  cTitle := WinGetTitle(cId)
  cClass := WinGetClass(cId)
  WinGetPos(&cX, &cY, &cW, &cH, cId)
  cExe := WinGetProcessName(cId)
  cPath := WinGetProcessPath(cId)
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
    ontop_GUIs.%hwnd%.timer := () => PositionDot(hwnd)
    SetTimer(ontop_GUIs.%hwnd%.timer, 10)
  } else {
    WinSetAlwaysOnTop 0, hwnd
    if (ontop_GUIs.HasOwnProp(hwnd)) {
      ontop_GUIs.%hwnd%.Destroy()
      SetTimer(ontop_GUIs.%hwnd%.timer, 0)
      ontop_GUIs.DeleteProp(hwnd)
    }
  }
  PositionDot(hwnd) {
    ; 窗口是激活的渲染显示，没激活不用管。如果窗口已关闭，则清除定时器
    if (!WinExist(hwnd)) {
      ontop_GUIs.%hwnd%.Destroy()
      SetTimer(ontop_GUIs.%hwnd%.timer, 0)
      ontop_GUIs.DeleteProp(hwnd)
    }
    else if (WinActive(hwnd)) {
      WinGetPos(&actX, &actY, &actW, &actH, hwnd)
      ontop_GUIs.%hwnd%.Show(Format("x{} y{} w10 h10 NoActivate", actX + actW - 21, actY + 3))
      WinSetAlwaysOnTop 1, ontop_GUIs.%hwnd%.Hwnd
    }
  }
}