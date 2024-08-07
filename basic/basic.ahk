#Requires AutoHotkey v2.0
; #NoTrayIcon
#include "basic_spy.ahk"
#include "basic_tool.ahk"
#include "basic_comm.ahk"
DetectHiddenWindows True
InstallKeybdHook
InstallMouseHook ;检测不到罗技鼠标更多的按键
KeyHistory 500
^ESC::ExitApp()
~^s::Reload()
~PrintScreen & ScrollLock::mouse_spy_exe()
; shift+小键盘比较特殊，能用，会改变输入法中英状态，松开时再变回来
NumpadIns::w_hide_show() ;+Numpad0
NumpadEnd::w_move(1) ;+Numpad1
NumpadDown::w_move(2) ;+Numpad2
NumpadPgdn::w_move(3) ;+Numpad3
NumpadLeft::tip(4) ;+Numpad4
NumpadClear::tip(5) ;+Numpad5
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
    ; 记住当前窗口和鼠标位置，点去再回来
    mouse_spy()
    tip mX " " mY " " wId " "
    WinActivate "原神 ahk_class UnityWndClass"
    click
    WinActivate wId
    click mX,mY,0
}
pgdn5(){
    tip 5
}
pgdn6(){
    tip 6
}
pgdn7(){
    comm_write("通过comm与其他程序通信")
}
pgdn8(){
    tip comm_read()
}
/*
一些工具函数
*/
func_select(arr,keep_appear_times:=1){
    ; 传入二维数组arr,[[判断函数，执行函数],...]
    reset_arr:=zeros(arr.Length)
    count_arr:=reset_arr
    loop{
        for k,v in arr{
            if(v[1]()){
                if(count_arr[k]==0){
                    count_arr:=reset_arr
                    count_arr[k]:=count_arr[k]+1
                }else{
                    count_arr[k]:=count_arr[k]+1
                }
                if(count_arr[k]>=keep_appear_times){
                    tip "func_select执行: " k
                    if(v.Has(2)){
                        v[2]() 
                    }
                    return k
                }
            }
        }
        sleep 100
    }
}
getpix(x,y,color,similar:=0){
    PixelSearch &fx, &fy, x, y, x, y, color, similar
    if(fx!=""){
        return [x,y,color]
    }else{
        return
    }
}
mgetpix(arr){
    ; arr:=[[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]]
    ; arr:=[[1320,884,0x222022,6], [2344,888,0x672337,6]]
    find:=[]
    for k,v in arr{
        if(!v.Has(4)){
            v.push(0)
        }
        PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
        if(fx!=""){
            find.push(v)
        }
    }
    if(find.length==arr.length){
        return find
    }else{
        return
    }
}
waitpix(x,y,color,similar:=0,appear_times:=1,function:=()=>{},interval:=100,timeout:=0){
    StartTime := A_TickCount
    num:=0
    loop{
        PixelSearch &fx, &fy, x, y, x, y, color, similar
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(fx!=""){
                num++
                if(num>=appear_times){
                    ; tip "waitpix ok,appear_times:" num
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(fx==""){
                num--
                if(num<=appear_times){
                    ; tip "waitpix ok,appear_times:" num
                    return [x,y,color]
                }
            }else{
                num:=0
            }
        }
        function()
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            return "timeout"
        }
    }
}
; waitpix如果容易误判的，就用mwaitpix加多几个pix增强可信度
mwaitpix(arr,correct_offset:=0,appear_times:=1,function:=()=>{},interval:=100,timeout:=0){
    ; arr:=[[x,y,color,similar],...]
    StartTime := A_TickCount
    num:=0
    loop{
        correct:=[]
        for k,v in arr{
            if(!v.Has(4)){
                v.push(0)
            }
            PixelSearch &fx, &fy, v[1], v[2], v[1], v[2], v[3], v[4]
            if(fx!=""){
                correct.Push(v)
            }
        }
        tip "correct: " correct.Length ",timeout:" timeout
        if(appear_times>=0){
            ; 可运行直到确认出现须积累的次数,0和1效果一样，都找到就退出
            if(correct.Length>=arr.length-correct_offset){
                num++
                if(num>=appear_times){
                    return correct
                }
            }else{
                num:=0
            }
        }else{
            ; 可运行直到确认消失须积累的次数
            if(correct.Length<arr.length-correct_offset){
                num--
                if(num<=appear_times){
                    return correct
                }
            }else{
                num:=0
            }
        }
        function() ;可以为""不会报错
        sleep interval
        if(timeout>0 && A_TickCount-StartTime>timeout){
            return "timeout"
        }
    }
}
