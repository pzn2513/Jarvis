F11::ExitApp
F12::reload

; hotkey_info := "^ctrl, +shift, !alt, #win, 其他键组合使用需要 & 连接，注意前后要有空格, 默认有拦截效果，用~可以传递不拦截"
#e::{
    hotkey_info := "^ctrl, +shift, !alt, #win, AppsKey菜单键, "
    TrayTip("标题", hotkey_info, 5) ; 显示 5 秒钟
}

~#r::{
    MsgBox("默认有拦截效果，用~可以传递不拦截")
}

^+!#AppsKey::{
    MsgBox("按下了 A 键")
}