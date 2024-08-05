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
            ; sleep 1000
            零号业绩_上路()
            break
        }else if(mgetpix([[1322,885,0xEB2F25,6], [1384,888,0x682538,6]])){
            ; msgbox_autoclose "零号业绩_下路"
            tip "零号业绩_下路"
            ; sleep 1000
            零号业绩_下路()
            break
        }
        sleep 100
    }
}
零号业绩_start(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 665,700,0x7838CE,0 ;主界面
    click(665,700)
    waitpix 1632,380,0xADE105,0 ;列车2
    click(1632,380)
    waitpix 1704,1027,0xFFFFFF,0,-20,()=>click(1734,1027) ;确认-出战
    ; 有的没有鸣徽选择
    loop{
        if(getpix(952,792,0xFFFFFF)){ ;选择鸣徽
            tip("选择鸣徽")
            click(952,792)
            break
        }else if(getpix(1291,363,0x343334)){ ;聊天框
            tip("聊天框")
            break
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
    send("{alt Down}}")
    sleep 30
    send("{alt Up}}")
    sleep 100
    send("{r Down}}")
    sleep 800
    send("{r Up}}")
    sleep 800
    send("{d Down}")
    sleep 30
    send("{d Up}")
    sleep 100
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    click(952,792)
    sleep 500
    send("{d Down}")
    sleep 30
    send("{d Up}")
    sleep 100
    send("{w Down}")
    sleep 30
    send("{w Up}")
    sleep 100
    send("{w Down}")
    sleep 30
    send("{w Up}")
    sleep 100
    waitpix 1366,572,0xD9D8D9,0 ;确认继续
    click(1366,572)
    零号业绩_battle()
    零号业绩_get_reward()

}
零号业绩_下路(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    sendstd "alt"
    sendstd "s",400
    waitpix 1291,363,0x343334,0 ;聊天框
    waitpix 1376,679,0xD9D8D9,0,1,()=>click(1476,679) ;这次不用
    loop 8{
       click(1476,679)
       sleep 200
    }
    send("{r Down}}")
    sleep 800
    send("{r Up}}")
    sleep 800
    send("{s Down}")
    sleep 30
    send("{s Up}")
    sleep 100
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    click(952,792)
    sleep 500
    send("{d Down}")
    sleep 30
    send("{d Up}")
    sleep 100
    send("{d Down}")
    sleep 30
    send("{d Up}")
    sleep 100
    waitpix 1366,572,0xD9D8D9,0 ;确认继续
    click(1366,572)
    零号业绩_battle()
    零号业绩_get_reward()
}
零号业绩_battle(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 1563,963,0x979697,0 ;战斗开始 灰色闪避
    loop{
        零号业绩_shark_fight()
        if(getpix(560,309,0x41C01D)){ ;战斗结束 绿球 有奖励
            waitpix 1147,959,0xFFFFFF ;确认
            click(1147,959)
            break
        }else if(getpix(560,373,0x41C01D)){ ;战斗结束 绿球 无奖励
            waitpix 1020,889,0x00CC0D ;确认
            click(1020,889)
            break 
        }
        sleep 100
    }
    ; waitpix 560,266,0x44C41C,0,0,()=>零号业绩_shark_fight() ;战斗结束 绿球
    ; waitpix 1020,993,0x00CC0D,0 ;确认
    ; click(1021,992)
    ; 调查点达到上限后位置会上移
    ; waitpix 560,373,0x41C01D,0,0,()=>零号业绩_shark_fight() ;战斗结束 绿球
    ; waitpix 1020,889,0x00CC0D,0 ;确认
    ; click(1020,889)
    waitpix 952,792,0xFFFFFF,0 ;选择鸣徽
    click(952,792)
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
    waitpix 1212,995,0xFFD230,0 ;黄齿轮
    ; 这里可优化成重复w直到行动
    sleep 1000
    send("{alt Down}")
    sleep 30
    send("{alt Up}")
    sleep 100
    send("{w Down}")
    sleep 30
    send("{w Up}")
    sleep 100
    waitpix 1324,523,0x313131,0,0,()=>click(1490,734) ; ;假面研究，选3
    sleep 100
    click(1490,734)
    sleep 100
    waitpix 1577,130,0xB83736,10,0,()=>click(961,807) ; ;s
    click(1577,130)
    零号业绩_get_reward1()
}
零号业绩_get_reward1(){
    WinActivate("绝区零 ahk_class UnityWndClass")
    waitpix 1291,363,0x343334,0 ;s的框
    waitpix 1291,363,0x343334,0,-2,()=>click(1291,363) ;s的框
    sleep 1000
    send("{d Down}")
    sleep 30
    send("{d Up}")
    sleep 100
    send("{w Down}")
    sleep 30
    send("{w Up}")
    sleep 100
    零号业绩_giveup()
}
零号业绩_giveup(){
    waitpix 1594,1027,0xCB0000,0,0,()=>sendstd("esc") ;放弃
    click(1594,1027)
    waitpix 1120,627,0xF8F8F8,0 ;确认
    click(1120,627)
    waitpix 1690,1030,0xFFFFFF,0 ;完成
    waitpix 1690,1030,0xFFFFFF,0,-15,()=>click(1600,1030) ;完成
    sleep 3000
}



