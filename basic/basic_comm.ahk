; communication，通过文件进行通信
comm_path := "../.communication"
comm_write(msg,path:=comm_path){
    ; 执行1000次5406ms，单次5.4ms左右，会频繁删除创建打开关闭文件
    ; 效率可优化，见FileOpen https://autohotkey.top/AutoHotkey2.0/docs/lib/FileOpen.htm
    if FileExist(path)
        FileDelete(path)
    FileAppend(msg, path)
}
comm_read(path:=comm_path){
    ; 执行10000次230ms，单次0.023ms左右
    return FileRead(path)
    ; tip(content)
}


comm_test_fileselect(){
/* 
https://autohotkey.top/AutoHotkey2.0/docs/lib/FileSelect.htm
如果省略, 则它默认为 0, 这等同于下面的任意选项都没有指定.

否则, 它可以是一个数字或下面列出的字母之一, 可选择在后面加一个数字. 例如, "M", 1 和 "M1" 都是有效的(但不相同).

D: 选择文件夹(目录). 指定字母 D, 允许用户选择文件夹而不是文件. 该对话框具有与选择文件时相同的大部分功能, 但不支持过滤器(Filter 必须省略或置空).

M: 多选. 指定字母 M 让用户可以使用 Shift+点击, Control+点击或其他方法来选择多个文件. 在这种情况下, 返回值是一个数组不是一个字符串. 要提取单个文件, 请参阅本页底部的示例.

S: 保存对话框. 指定字母 S 让对话框显示保存按钮代替打开按钮.

可以使用以下数字. 要使其中多个数字生效, 请将它们相加. 例如, 要使用 1 和 2, 请指定数字 3.

1: 文件必须存在
2: 路径必须存在
8: 提示创建新文件
16: 提示覆盖文件
32: 选择快捷方式本身(.lnk 文件) 而不解析为它们的目标. 此选项也避免了通过文件夹快捷方式跳转到那个文件夹的情况.

由于 "提示覆盖" 选项只有保存对话框支持, 因此在没有 "提示创建" 选项的情况下指定该选项也会使 S 选项生效. 同样, 当 S 选项存在时, "提示创建" 选项也没有效果. 指定数字 24 可以启用对话框支持的任何一种提示类型.
*/
    ; select := FileSelect(3, , "Open a file", "Text Documents (*.txt; *.doc)")
    ; select := FileSelect("M3")  ; M3 = 选择多个现有文件.
    select := FileSelect("D", , "Select a folder")
    if select = ""
        MsgBox "The user didn't select anything."
    else
        MsgBox "The user selected the following:`n" select    
}