#include "./basic/basic.ahk"
#include "./绝区零/绝区零.ahk"
#include "./原神/原神.ahk"
#include "./星铁/星铁.ahk"

/* 在此自定义实用快捷键 */
NumpadLeft:: help原神() ;+Numpad4
NumpadClear:: help星铁() ;+Numpad5
NumpadRight:: tip(6) ;+Numpad6
NumpadHome:: tip(debug_json) ;+Numpad7
NumpadUp:: tip(8) ;+Numpad8
NumpadPgUp:: tip(9) ;+Numpad9
!esc:: w_hide_show("esc")
; !f1::tip(1)
; !f2::tip(2)
; !f3::tip(3)
; !f4::tip(4)
; !f5::tip(5)
; !f6::tip(6)
; !f7::tip(7)
; !f8::tip(8)
; !f9::tip(9)
; !f0::tip(0)
!`:: w_hide_show("~")
!1:: w_move(0)
!2:: w_move(1)
!3:: w_move(2)
!4:: tip(4)
!5:: tip(5)
!6:: tip(6)
; +f1::tip(1)

; 一些win键没用甚至副作用，拦截掉
; 下排
#AppsKey:: tip("#AppsKey")
; #space:: tip("#space")
#/:: tip("#/")
#.:: tip("#.")
#,:: tip("#,")
#m:: tip("#m")
#n:: tip("#n")
#b:: tip("#b")
; #v 剪切板
#c:: tip("#c")
#x:: tip("#x")
#z:: tip("#z")
; 中排
#enter:: tip("#enter")
#':: tip("#'")
#;:: tip("#;")
; #L 🔒
#k:: tip("#k")
#j:: tip("#j")
#h:: tip("#h")
#g:: tip("#g")
#f:: tip("#f")
; #d 显示桌面
#s:: mouse_spy_exe()
; #a 消息中心
; 上排
#\:: tip("#\")
#]:: tip("#]")
#[:: tip("#[")
#p:: tip("#p")
#o:: tip("#o")
#i:: tip("#i")
#u:: tip("#u")
#y:: tip("#y")
#t:: w_top_toggle()
#w:: tip("#w")
#q:: tip("#q")
#backspace:: tip("#backspace")
; #+ #- 屏幕放大缩小工具
; #0-9 切换程序
; #` 控制台
; #tab 桌面视图
#CapsLock:: tip("#CapsLock")
; #esc:: tip("#esc")
#f1:: telegram
#f2:: postman
#f3:: xmind
; #f3:: 
; #f4:: tip("#f4")
; #f5:: tip("#f5")
; #f6:: tip("#f6")
; #f7:: tip("#f7")
; #f8:: tip("#f8")
; #f9:: tip("#f9")
; #f10:: tip("#f10")
; #f11:: tip("#f11")
#f12:: telegram

telegram() {
  showhide("ahk_class Qt51515QWindowIcon ahk_exe Telegram.exe", "C:\Users\pznfo\AppData\Roaming\Telegram Desktop\Telegram.exe")
}
postman() {
  showhide("ahk_exe Postman.exe", "C:\Users\pznfo\AppData\Local\Postman\app-11.20.0\Postman.exe")
}
xmind() {
  showhide("ahk_exe Xmind.exe", "C:\Users\pznfo\AppData\Local\Programs\Xmind\Xmind.exe")
}
showhide(a, b) {
  hwnd := WinExist(a)
  if (hwnd) {
    style := WinGetStyle(hwnd)
    isVisible := (style & WS_VISIBLE) != 0
    if (isVisible) {
      if (WinActive(hwnd)) {
        WinMinimize(hwnd)
        return
      } else {
        WinRestore(hwnd)
        WinActivate(hwnd)
        return
      }
    } else {
      ; 对于隐藏在托盘处的窗口，似乎没有很好的办法
    }
  }
  run b
  sleep 300
  WinActivate(a)
}