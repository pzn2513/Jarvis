#HotIf WinActive("ahk_class Notepad")
^!c::MsgBox "You pressed Control+Alt+C in Notepad."
#HotIf WinActive("ahk_class WordPadClass")
^!c::MsgBox "You pressed Control+Alt+C in WordPad."
#HotIf
; ^!c::MsgBox "You pressed Control+Alt+C in a window other than Notepad/WordPad."
basic_test9() {
    id:=WinGetID("A")
    ; id:=WinActive("A")
    ; id:=WinExist("A")
    msgbox_autoclose id
}
basic_test8() {
    sendstd "d"
}
basic_test7() {

}
basic_test6() {

}
basic_test5() {

}
basic_test4() {

}
basic_test3() {

}
basic_test2() {

}
basic_test1() {

}
basic_test0() {
    StartTime := A_TickCount
    sleep 111
    EndTime := A_TickCount
    ElapsedTime := EndTime - StartTime
    tip "用时：" ElapsedTime "ms"
}