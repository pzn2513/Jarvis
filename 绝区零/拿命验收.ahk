拿命验收(){
    WinActivate "绝区零 ahk_class UnityWndClass"
    count:=0
    loop{
        if(getpix(1236, 52, 0xE4CC00, 6)){ ;HDD首页 黄球
            waitpix(1236, 52, 0xE4CC00, 6,-4,()=>click(921,667)) ;点到消失
            break
        }else if(getpix(1512, 1023, 0x1B1B1B, 6)){ ; 累了 对话框边框
            ; tip 2222
            拿命验收_shafa()
        }else{
            if(count>25){
                ; tip 3333
                拿命验收_M2HDD() 
            }
        }
        count++
        sleep 200
    }
    waitpix(1630, 846, 0xF741A5, 6) ;HDD列表
    if(getpix(1142,845,0xF4F4F4)){
        click 1200,845
    }else{
        ; MouseClickDrag "left", 1402, 800, 1402, 400 ;上划
        SendEvent("{Click 1402 800 Down}{click 1402 300 Up}")
        sleep 500
        waitpix(1141,599,0xAAAAAA,6,0,()=>SendEvent("{Click 1402 800 Down}{click 1402 300 Up}"),500) ;比input兼容性强
        click 1334,599        
    }
    sleep 100
    click 1719,1035
    waitpix(1726, 49, 0xcccccc, 6,-25,()=>click(1719,1035)) ;队伍
    /*
    打箱子精细操作
    */
    WinActivate "绝区零 ahk_class UnityWndClass"
    waitpix 1563,963,0x979697,0 ;战斗开始 灰色闪避
    Send "{w Down}"
    Sleep 250
    Click "R D"
    Sleep 100
    Click "R U"
    Sleep 300
    Click "D"
    Sleep 100
    Click "U"
    Sleep 200
    Send "{Space Down}"
    Sleep 100
    Send "{Space Up}"
    Sleep 100
    Click "R D"
    Sleep 300
    Send "{d Down}"
    Sleep 1350
    Send "{d Up}"
    Sleep 1200
    Send "{d Down}"
    res:=waitpix(969,815,0xFFFFFF,0,3,()=>sendstd("f",100),100,6000) ;完成
    Send "{d Up}"
    Sleep 10
    Send "{w Up}"
    Sleep 10
    Click "R U"    
    if(res=="timeout"){
        waitpix 1594,1027,0xCB0000,0,1,()=>sendstd("esc") ;放弃
        click(1594,1027)
        waitpix 1120,627,0xF8F8F8,0 ;确认
        click(1120,627)
    }else{
        waitpix 1690,1030,0xFFFFFF,0,1,()=>click(1511,662) ;完成
        waitpix 1690,1030,0xFFFFFF,0,-25,()=>click(1720,1030) ;完成
    }
    Sleep 4000
    拿命验收()
}

拿命验收_shafa(){
    /*
    沙发爬起来继续，点到界面出现
    */
    WinActivate "绝区零 ahk_class UnityWndClass"
    waitpix(1777, 897, 0xFFFFFF, 0,5,()=>click())
    sendstd "d",20,400
    send "{s Down}"
    Sleep 400
    sendstd "a",20,500
    send "{d Down}"
    res:=waitpix(1236, 52, 0xE4CC00,6,1,()=>sendstd("f"),100,3000)
    send "{s Up}"
    send "{d Up}"
    if(res=="timeout"){
        拿命验收_M2HDD()
    }else{
        拿命验收()
    }
    ; Send "{d Down}"
    ; Sleep 94
    ; Send "{s Down}"
    ; Sleep 406
    ; Send "{a Down}"
    ; Sleep 16
    ; Send "{d Up}"
    ; Sleep 406
    ; Send "{d Down}"
    ; Sleep 16
    ; Send "{a Up}"
    ; Sleep 400
    ; Send "{f Down}"
    ; Sleep 171
    ; Send "{f Up}"
    ; Sleep 157
    ; Send "{f Down}"
    ; Sleep 125
    ; Send "{f Up}"
    ; Sleep 125
    ; Send "{f Down}"
    ; Sleep 200
    ; Send "{f Up}"
    ; Send "{s Up}"
    ; Send "{d Up}"
    ; Sleep 600    
}

拿命验收_M2HDD(){
    ; m档案架-》HDD
    WinActivate "绝区零 ahk_class UnityWndClass"
    waitpix 1775,896,0xFFFFFF,0,1,()=>sendstd(["esc","LBUTTON"]),700
    waitpix 1775,896,0xFFFFFF,0,-1,()=>sendstd("m")
    click 976,451,0
    ; mwaitpix [[849,642,0x000000],[1070,648,0x5D5D5D]],0,1,()=>send("{WheelDown}"),1000
    ; mwaitpix [[849,642,0x000000],[1070,648,0x5D5D5D]],0,-1,()=>click(507,985)
    mwaitpix [[849,642,0x000000]],0,1,()=>send("{WheelDown}"),1000
    mwaitpix [[849,642,0x000000]],0,-1,()=>click(507,985)
    waitpix 1775,896,0xFFFFFF,0,1,()=>Click(1030,622)
    sendstd "d",20,1300
    sendstd "s",20,700
    sendstd "d",20,400
    res:=waitpix(1236, 52, 0xE4CC00,6,1,()=>sendstd("f"),100,2000)
    if(res=="timeout"){
        拿命验收_M2HDD()
    }else{
        拿命验收()
    }
}