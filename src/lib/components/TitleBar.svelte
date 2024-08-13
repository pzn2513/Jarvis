<script>
  /** @type {import('electron').IpcRenderer | undefined} */
  let ipcRenderer;
  
  if (typeof window !== 'undefined' && window.process && window.process.type === 'renderer') {
    // 仅在Electron环境中导入
    ipcRenderer = require('electron').ipcRenderer;
  }
                                                                                         
  function minimize() {
    if (ipcRenderer) ipcRenderer.send('window-control', 'minimize');
  }

  function maximize() {
    if (ipcRenderer) ipcRenderer.send('window-control', 'maximize');
  }

  function close() {
    if (ipcRenderer) ipcRenderer.send('window-control', 'close');
  }
</script>

<div class="title-bar">
  <div class="title"></div>
  <div class="window-controls">
    <button on:click={minimize}>—</button>
    <button on:click={maximize}>□</button>
    <button on:click={close}>X</button>
  </div>
</div>

<style>
  .title-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1px;
    background-color: #282c34 transparent;
    color: white;
    -webkit-app-region: drag; /* 使标题栏可拖动 */
  }

  .window-controls button {
    /* margin-left: 5px; */
    background: none;
    border: none;
    color: white;
    font-size: 14px;
    -webkit-app-region: no-drag; /* 使按钮不可拖动 */
  }
</style>
