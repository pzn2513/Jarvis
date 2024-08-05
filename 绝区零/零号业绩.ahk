零号业绩循环(){
    loop{
        零号业绩()
    }
}
零号刷特殊区域(){
    loop{
        特殊区域()
    }
}
特殊区域(){
    零号业绩_start()
    ; 分析路线 1316, 225,0x324147
    loop{
        if(mgetpix([[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]])){
            ; msgbox_autoclose "零号业绩_上路"
            tip "零号业绩_上路"
            ; sleep 1000
            特殊区域_上路()
            break
        }else if(mgetpix([[1322,885,0xEB2F25,6], [1384,888,0x682538,6]])){
            ; msgbox_autoclose "零号业绩_下路"
            tip "零号业绩_下路"
            ; sleep 1000
            特殊区域_下路()
            break
        }
        sleep 100
    }
}
零号业绩(){
    零号业绩_start()
    ; 分析路线 1316, 225,0x324147
    loop{
        if(mgetpix([[1317, 226, 0x3C3A44,6], [1381, 224, 0x313B49,6]])){
            ; msgbox_autoclose "零号业绩_上路"
            tip "零号业绩_上路"
            ; sleep 200
            零号业绩_上路()
            break
        }else if(mgetpix([[1322,885,0xEB2F25,6], [1384,888,0x682538,6]])){
            ; msgbox_autoclose "零号业绩_下路"
            tip "零号业绩_下路"
            ; sleep 200
            零号业绩_下路()
            break
        }
        sleep 100
    }
}
零号业绩_start(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 665,700,0x7838CE,0 ;主界面
    waitpix 665,700,0x7838CE,0,-2,()=>click(700,700) ;主界面
    waitpix 1632,380,0xADE105,0 ;列车2
    click(1632,380)
    waitpix 1704,1027,0xFFFFFF,0,-10,()=>temp_func() ;确认-出战
    temp_func(){
        click(1734,1027)
        Sleep 100
        click(1110,626)
    }
    waitpix 210,46,0xE3E3E3,0 ;入场，按alt加速
    waitpix 210,46,0xE3E3E3,0,-1,()=>sendstd("alt") ;入场，按alt加速
    ; 有的没有鸣徽选择
    reset_arr:=[0,0]
    count_arr:=reset_arr
    loop{
        if(getpix(952,792,0xFFFFFF)){ ;选择鸣徽
            if(count_arr[1]==0){
                count_arr:=reset_arr
                count_arr[1]:=count_arr[1]+1
            }else{
                count_arr[1]:=count_arr[1]+1
            }
            if(count_arr[1]>2){
                sleep 200
                click(952,792)
                break    
            }
        }else if(getpix(1291,363,0x343334)){ ;聊天框
            if(count_arr[2]==0){
                count_arr:=reset_arr
                count_arr[2]:=count_arr[2]+1
            }else{
                count_arr[2]:=count_arr[2]+1
            }
            if(count_arr[2]>2){
                break
            }
        }
        sleep 100
    }
    waitpix 1849,88,0x242424,5,2,()=>click(1372,678) ;拒绝好意
}
特殊区域_上路(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    
    零号业绩_giveup()
}
特殊区域_下路(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    sendstd "alt"
    sendstd "d",1500
    click(952,792)
    零号业绩_giveup()
}
零号业绩_上路(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    ; sendstd "alt"
    sendstd "r",800,800
    sendstd "d"
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    waitpix 952,792,0xFFFFFF,0,-2,()=>click(952,792) ;选择鸣徽
    sleep 600
    sendstd "d"
    sendstd "w"
    sendstd "w"
    零号业绩_battle()
    零号业绩_get_reward()
}
零号业绩_下路(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    ; sendstd "alt"
    sendstd "s"
    waitpix 1291,363,0x343334,0 ;聊天框
    waitpix 1376,679,0xD9D8D9,0,1,()=>click(1476,679) ;不用支援
    waitpix 1376,679,0xD9D8D9,0,-13,()=>click(1476,679) ;不用支援
    sendstd "r",800,800
    sendstd "s"
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    waitpix 952,792,0xFFFFFF,0,-2,()=>click(952,792) ;选择鸣徽
    sleep 600
    sendstd "d"
    sendstd "d"
    零号业绩_battle()
    零号业绩_get_reward()
}
零号业绩_battle(){
    waitpix 1366,572,0xD9D8D9,0 ;确认继续
    waitpix 1366,572,0xD9D8D9,0,-2,()=>click(1466,572) ;确认继续
    Sleep 5000
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 1563,963,0x979697,0 ;战斗开始 灰色闪避
    loop{
        零号业绩_shark_fight()
        if(getpix(560,309,0x41C01D)){ ;战斗结束 绿球 有调查点 有奖励
            waitpix 560,309,0x41C01D,0,-3,()=>click(1136,1002)
            break
        }else if(getpix(560,266,0x44C41C)){ ;战斗结束 绿球 无调查点 有奖励
            waitpix 560,266,0x44C41C,0,-3,()=>click(1136,1002)
            break 
        }else if(getpix(560,373,0x41C01D)){ ;战斗结束 绿球 无调查点 无奖励
            waitpix 560,373,0x41C01D,0,-3,()=>click(1136,1002)
            break 
        }
        sleep 100
    }
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    waitpix 952,792,0xFFFFFF,0,-2,()=>click(952,792) ;选择鸣徽
}
零号业绩_shark_fight(){
    ; dw right left*10
    send("{d Down}")
    sleep 30
    send("{w Down}")
    sleep 30
    click "R D"
    sleep 260
    click "R U"
    sleep 30
    send("{d Up}")
    sleep 30
    loop 7{
        click
        sleep 100
    }
    send("{w Up}")
}
零号业绩_get_reward(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 210,46,0xE3E3E3,0 ;入场，按alt加速
    waitpix 210,46,0xE3E3E3,0,-1,()=>sendstd("alt") ;入场，按alt加速
    waitpix 1296,359,0x343534,0,1,()=>sendstd("w") ; ;假面研究对话出现
    waitpix 1324,523,0x313131,0,1,()=>click(1490,734) ; ;假面研究3选项出现，选3
    sleep 100
    click(1490,734)
    sleep 100
    waitpix 1577,130,0xB83736,10,0,()=>click(961,807) ; s门
    sleep 300
    click(1577,130)
    零号业绩_get_reward1()
}
零号业绩_get_reward1(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 1291,363,0x343334,0 ;s门对话框
    waitpix 1291,363,0x343334,0,-5,()=>click(1291,363) ;s门对话框
    sleep 1200
    sendstd "d"
    sendstd "w"
    零号业绩_giveup()
}
零号业绩_giveup(){
    waitpix 1594,1027,0xCB0000,0,1,()=>sendstd("esc") ;放弃
    click(1594,1027)
    waitpix 1120,627,0xF8F8F8,0 ;确认
    click(1120,627)
    waitpix 1690,1030,0xFFFFFF,0 ;完成
    waitpix 1690,1030,0xFFFFFF,0,-15,()=>click(1600,1030) ;完成
    sleep 3000
}



