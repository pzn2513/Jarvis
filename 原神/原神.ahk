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
#CapsLock:: help原神
help原神() {
  ; 有狂点快速过(开发时)和自动悠闲过
  ; 过各种对话,点到各种框,全屏幕模式默认放在最右侧
  loop {
    A_CoordModeToolTip := "Screen"
    A_CoordModePixel := "Screen"
    A_CoordModeMouse := "Screen"
    ; 5137,567,0xFFFFFF
    ; 5137,641,0xFFFFFF
    ; 5137,715,0xFFFFFF
    ToolTip "help原神: 闲", 1920 * 1, 0, 20
    if (mgetpix([[2879, 1007, 0xD3C294, 6], [2067, 60, 0xF1D599, 6]])) { ;对话中
      ToolTip "help原神: 对话中", 1920 * 1, 0, 20
      block_click(2879, 1007)
      ; send "{alt down}"
      ; send "{alt up}"
    }
    else if (mgetpix([[3227,726,0x878D95,16], [3209,726,0x969CA2, 16]])) { ;对话选项从上往下选2
      block_click(3267,724)
    }
    else if (mgetpix([[3210,801,0x6E757E,16], [3226,803,0x626A74, 16]])) { ;对话选项从上往下选1
      block_click(3268,799)
    }
    else if (mgetpix([[1999,48,0x9F8E6C,16], [3761,45,0xA18F6C, 16]])) { ;对话选项从上往下选3
      block_click(3761,45)
    }
    sleep 250
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