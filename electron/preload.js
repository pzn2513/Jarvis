const { contextBridge, ipcRenderer } = require('electron')

window.addEventListener('DOMContentLoaded', () => {
  console.log('preload loaded')
})
// bridge通讯
// ipcRenderer
contextBridge.exposeInMainWorld('electron', {
  version: process.versions,
  smg:(target,data)=>{
    console.log('preload smg:'+target)
    ipcRenderer.send(target,data)
  },
  readFile:()=>{
    return ipcRenderer.invoke('readFile')
  },
  onMessage:func=>{
    return ipcRenderer.on('message',func)
  }
})
