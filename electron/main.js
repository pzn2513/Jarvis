import {app,BrowserWindow,ipcMain} from 'electron';
import * as path from 'path';
import {fileURLToPath} from 'url';
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
    webPreferences: {
      // preload: path.join(__dirpath, './preload.js'),
      preload: 'D:/Program Files/wisehub/resources/output/electron/preload.js',
    },
  });
  win_list.push(win)
  if (process.env.NODE_ENV === 'development') {
    win.loadURL('http://localhost:5173');
    win.webContents.openDevTools();
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
  const win = createWindow()
  win.loadURL(data)
})
ipcMain.handle('readFile', () => {
  return "read11111"
})

app.on('ready', () => createWindow(1920, 1080));

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});