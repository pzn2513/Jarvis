# 构建步骤
```
npm create svelte@latest wisehub_svelte  
cd wisehub_svelte  
npm i electron electron-builder cross-env  -D
npm run dev -- --open
```

# 创建/复制 electron项目，配置json<只显示增量>
```
"main": "electron/main.js",
"scripts": {
    "start": "cross-env NODE_ENV=development electron .",
    "test": "vite build & electron .",
    "build": "vite build --mode production && electron-builder",
},
"build": {
    "productName": "WiseHub",
    "directories": {
      "output": "dist/electron-builder"
    },
    "win": {
      "target": [{
          "target": "nsis",
          "arch": ["x64"]
        }]
    },
    "nsis": {
        "oneClick": false,
        "allowToChangeInstallationDirectory": true
    }
},
```
静态文件打包到时跟反逆向一起研究，目前用development

# 反编译electron项目
```
安装asar，./resources/app.asar可逆向
npx asar extract .\app.asar output
```
![alt text](image.png)
逆向后出现了整个项目的文件，也是挺让人头疼的  
需要想办法做混淆和反逆向工程。  
不过做原型先不用考虑这么多，先跑出核心功能，再解决这些问题（肯定有方法）。