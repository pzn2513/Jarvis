#include "../basic/basic.ahk"
#HotIf WinActive("星穹铁道 ahk_class UnityWndClass")
Delete::星铁弃置()
~AppsKey & Numpad0:: t00()
#HotIf

星铁弃置(){
    block_click(1861,252,0)
}
help星铁() {
    A_CoordModeToolTip := "Screen"
    A_CoordModePixel := "Screen"
    A_CoordModeMouse := "Screen"
    loop {
        ; 5137,567,0xFFFFFF
        ; 5137,641,0xFFFFFF
        ; 5137,715,0xFFFFFF
        ToolTip "help星铁", 1920 * 2, 0, 20
        if (mgetpix([[5088, 758, 0xF1D599], [5180, 757, 0xFFFFFF]])) {
            ; 对话选项1
            ; block_click(5210,577)
            ; block_click(5210,651)
            ; block_click(5210,725)
            block_click(5234, 758)
        }
        ; else if(mgetpix([[4774,966,0xAE8708],[4798,1004,0x110600]])){
        ;     ; 点击后继续
        ;     block_click(4804,599)
        ; }
        sleep 1000
    }
}
t00() {
  ; waitpix 1757,743,0x4E9E63,16
  ; click 1676,984
  loop 9{
    Sleep 15000
    mwaitpix [[1455,947,0xF6F6F6],[997,353,0xF0D198]],0,1
    mwaitpix [[1455,947,0xF6F6F6],[997,353,0xF0D198]],0,-1,()=>click(1217,947)
    waitpix 1137,673,0xA5977B
    waitpix 1137,673,0xA5977B,0,-1,()=>click(1180,673)    
  }

}