export function applyBold() {
  const selection = window.getSelection();
  if (selection && selection.rangeCount > 0) {
    const range = selection.getRangeAt(0);
    const boldElement = document.createElement('strong');

    // 将选中的内容移入到 <strong> 元素中
    boldElement.appendChild(range.extractContents());
    range.insertNode(boldElement);
  }
}

export function applyItalic() {
  const selection = window.getSelection();
  if (selection && selection.rangeCount > 0) {
    const range = selection.getRangeAt(0);
    const italicElement = document.createElement('em');

    // 将选中的内容移入到 <em> 元素中
    italicElement.appendChild(range.extractContents());
    range.insertNode(italicElement);
  }
}

export function applyUnderline() {
  const selection = window.getSelection();
  if (selection && selection.rangeCount > 0) {
    const range = selection.getRangeAt(0);
    const underlineElement = document.createElement('u');

    // 将选中的内容移入到 <u> 元素中
    underlineElement.appendChild(range.extractContents());
    range.insertNode(underlineElement);
  }
}

export function createLink(url: string) {
  const selection = window.getSelection();
  if (selection && selection.rangeCount > 0) {
    const range = selection.getRangeAt(0);
    const anchor = document.createElement('a');
    anchor.href = url;

    // 将选中的内容移入到 <a> 元素中
    anchor.appendChild(range.extractContents());
    range.insertNode(anchor);
  }
}

// 其他自定义命令可以在这里继续添加
