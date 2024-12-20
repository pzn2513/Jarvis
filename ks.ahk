; keyboard shortcuts

~PrintScreen & ScrollLock:: mouse_spy_exe()
^+#Left:: mouse_spy_exe()
; shift+小键盘比较特殊，能用，会改变输入法中英状态，松开时再变回来 | 这按键和&按键远控不行

; pgup
pgup & Numpad7::tip(77)
; pgdn
pgdn & Numpad0:: tip("pgdn热键，拦截原功能，只做热键触发器")
pgdn & Numpad4:: tip(4)
pgdn & Numpad5:: tip(4)
pgdn & Numpad6:: tip(4)
pgdn & Numpad7:: linuxdo
pgdn & Numpad8:: tip(4)
~Pause & Numpad0:: tip("Pause热键，未拦截原功能，做热键触发器")
ScrollLock & Numpad0:: tip("ScrollLock热键，拦截原功能，只做热键触发器")
PrintScreen & Numpad0:: tip("PrintScreen热键，拦截原功能，只做热键触发器")
~Insert & Numpad0:: tip("Insert热键，拦截原功能，只做热键触发器")

; shift+numpad
NumpadIns:: w_hide_show(0) ;+Numpad0
NumpadEnd:: w_move(0) ;+Numpad1
NumpadDown:: w_move(1) ;+Numpad2
NumpadPgdn:: w_move(2) ;+Numpad3

linuxdo(){
  while(true){
    sendstd "down"
    sleep 150
  }
}
pgdn0(){

}
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