#HotIf WinActive("绝区零 ahk_class UnityWndClass")
~^Numpad0::零号业绩循环()
~^Numpad1::拿命验收循环()
~^0::拿命验收循环()
~^Numpad2::零号刷特殊区域()
~AppsKey & Numpad0::test_func_select()
~AppsKey & Numpad1::test_mwaitpix()
; #Numpad0::ttt()
#HotIf
#Include 零号业绩.ahk
#Include 拿命验收.ahk

test_func_select(){
    arr:=[
        [()=>getpix(952,792,0xFFFFFF),()=>tip(111)], 
        [()=>getpix(1291,363,0x343334),()=>tip(222)],
        [()=>getpix(1273,257,0x343534),()=>tip(333)],
    ]
    func_select(arr)
}
test_mwaitpix(){
    arr:=[
        [1278,458,0xFAAB2A],
        [1383,569,0xA71700],
        [1376,680,0xD9D8D9],
    ]
    mwaitpix(arr)
    mwaitpix(arr,0,-15,()=>Click(1409,672))
}
; ttt(){
;     InstallKeybdHook
;     InstallMouseHook
;     KeyHistory
; }