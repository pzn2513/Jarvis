import {
  app,
  BrowserWindow,
  ipcMain
} from 'electron';
import * as path from 'path';
import {
  fileURLToPath
} from 'url';
const __filepath = fileURLToPath(import.meta.url);
const __dirpath = path.dirname(__filepath);
console.log(__filepath)
console.log(__dirpath)
console.log(path.join(__dirpath, '../.svelte-kit/output/prerendered/pages/index.html'))
const win_list = []

function createWindow(w, h) {
  let win = new BrowserWindow({
    width: w,
    height: h,
    autoHideMenuBar: true,
    // frame: false,
    webPreferences: {
      // preload: path.join(__dirpath, './preload.js'),
      nodeIntegration: true, //允许在渲染进程中使用Node.js的核心模块和API，如 require()、process 等。
      contextIsolation: false, //在渲染进程中不使用上下文隔离
    },
  });
  // 处理窗口控制的IPC事件
  ipcMain.on('window-control', (event, action) => {
    if (action === 'minimize') {
      win.minimize();
    } else if (action === 'maximize') {
      win.isMaximized() ? win.unmaximize() : win.maximize();
    } else if (action === 'close') {
      win.close();
    }
  });
  return win
}

function open(url = '', w = 1200, h = 800) {
  const win = createWindow(w, h)
  if (process.env.NODE_ENV === 'development') {
    win.loadURL('http://localhost:5173' + url);
    if (url === '') {
      win.webContents.openDevTools();
    }
  } else {
    // win.loadFile('.svelte-kit/output/prerendered/pages/index.html');
    // win.loadFile('D:/Program Files/Lattics/resources/output/renderer/index.html');
    win.loadFile('D:/Program Files/wisehub/resources/output/dist/index.html');
    // win.loadFile(path.join(__dirpath, './dist/index.html'));
  }
}
// 创建窗口，通讯，状态管理
ipcMain.on('savefile', (event, data) => {
  console.log(data)
  fs.writeFileSync('./hello.txt', data)
})
ipcMain.on('newwin', (event, data) => {
  // const win = createWindow()
  // win.loadURL(data)
})
ipcMain.handle('readFile', () => {
  return "read11111"
})

app.on('ready', () => open());

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    open()
  }
});