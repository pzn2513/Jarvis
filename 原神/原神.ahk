#include "../basic/basic.ahk"

#HotIf WinActive("原神 ahk_class UnityWndClass")
~^Numpad0:: 零号业绩循环()
~^Numpad1:: 拿命验收()
; ~^0::拿命验收()
; ~^Numpad2::零号刷特殊区域()
CapsLock:: spin()
CapsLock Up:: global spin_stop := true
~AppsKey & Numpad0:: 原神_t0()
~AppsKey & Numpad1:: 原神_t1()
PgDn & Numpad7:: help原神
#HotIf

help原神() {
  ; 记住当前窗口和鼠标位置，点去再回来
  ; 处理原神 星铁 绝区零的选项，尽量不影响办公，轻松过剧情
  ; 目前先放3屏，后续做灵活兼容
  A_CoordModeToolTip := "Screen"
  A_CoordModePixel := "Screen"
  A_CoordModeMouse := "Screen"
  loop {
    ; 5137,567,0xFFFFFF
    ; 5137,641,0xFFFFFF
    ; 5137,715,0xFFFFFF
    ToolTip "help原神", 1920 * 2, 0, 20
    if (mgetpix([[5137, 790, 0xFFFFFF], [5129, 802, 0x5E6670, 20]])) {
      ; 对话选项
      ; block_click(5210,577)
      ; block_click(5210,651)
      ; block_click(5210,725)
      block_click(5210, 800)
    } else if (mgetpix([[4774, 966, 0xAE8708], [4798, 1004, 0x110600]])) {
      ; 点击后继续
      block_click(4804, 599)
    }
    sleep 1000
  }
}
spin() {
  ; 龙王旋转
  global spin_stop := false
  Loop 500 { ;过转保护
    DllCall("mouse_event", "UInt", 0x0001, "Int", 1000, "Int", 0, "UInt", 0, "Int", 0)
    sleep 10
    if spin_stop
      break
  }
}
原神_t0() {
  A_CoordModeToolTip := "Screen"
  A_CoordModePixel := "Screen"
  A_CoordModeMouse := "Screen"
  send "{alt down}"
  sleep 200
  block_click(5703, 62)
  send "{alt up}"
}
原神_t1() {

}
dll_mousemove(x, y, duration) {
  ;受鼠标速度影响，难以精确移动，xy主要提供方向和速度，duration为移动时间
  t0 := A_TickCount
  Loop {
    DllCall("mouse_event", "UInt", 0x0001, "Int", x, "Int", y, "UInt", 0, "Int", 0)
    sleep 10
    if A_TickCount - t0 >= duration
      break
  }
}