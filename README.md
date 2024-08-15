# 实现富文本编辑器
- 参考文章 https://juejin.cn/post/6920054071571251208#heading-12
- ![alt text](image.png)
- 模型：json 渲染：Svelte 编辑：拦截交互，自定义 指令：自定义execCommand
- 
# ------------------  此线以上更新进展  -------------------
# ------------------ 此线以下为构建步骤 -------------------
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

# 须注意的其他配置文件
- tsconfig.json
- svelte.config.js
- vite.config.js
- ./src/app.d.ts ts声明文件

# Flutter<主语>对比
- 跨平台
- 顶部frame的交互设计的更符合逻辑，有成熟好用的组件

# 何时转向
- 因功能相对复杂，先用sveltekit+electron快速开发实现主要功能(忽略UI，不追求细节)，再转向Flutter
