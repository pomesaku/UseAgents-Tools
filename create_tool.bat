@echo off
chcp 65001 > nul
echo ==========================================
echo 🛠️ 新しいWebツールを生成します
echo ==========================================
echo.

set /p tool_dir="1. 作成するフォルダ名（英数字 例: NewTool）: "
set /p app_name="2. アプリの正式名称（例: 神・割り勘ツール）: "
set /p short_name="3. スマホのホーム画面に表示する短い名前（例: 割り勘）: "

:: フォルダの作成
mkdir "%tool_dir%"

:: sw.jsの自動生成（1行ずつ確実に書き込む方式）
echo const CACHE_NAME = '%tool_dir%-v1'; > "%tool_dir%\sw.js"
echo const urlsToCache = [ './', './index.html', './manifest.json', './icon-192.png' ]; >> "%tool_dir%\sw.js"
echo. >> "%tool_dir%\sw.js"
echo self.addEventListener('install', event =^> { >> "%tool_dir%\sw.js"
echo   event.waitUntil(caches.open(CACHE_NAME).then(cache =^> cache.addAll(urlsToCache))); >> "%tool_dir%\sw.js"
echo }); >> "%tool_dir%\sw.js"
echo. >> "%tool_dir%\sw.js"
echo self.addEventListener('fetch', event =^> { >> "%tool_dir%\sw.js"
echo   event.respondWith(caches.match(event.request).then(response =^> response ^|^| fetch(event.request))); >> "%tool_dir%\sw.js"
echo }); >> "%tool_dir%\sw.js"

:: manifest.jsonの自動生成
echo { > "%tool_dir%\manifest.json"
echo   "name": "%app_name%", >> "%tool_dir%\manifest.json"
echo   "short_name": "%short_name%", >> "%tool_dir%\manifest.json"
echo   "start_url": "./", >> "%tool_dir%\manifest.json"
echo   "display": "standalone", >> "%tool_dir%\manifest.json"
echo   "background_color": "#ffffff", >> "%tool_dir%\manifest.json"
echo   "theme_color": "#455a64", >> "%tool_dir%\manifest.json"
echo   "icons": [ >> "%tool_dir%\manifest.json"
echo     { >> "%tool_dir%\manifest.json"
echo       "src": "icon-192.png", >> "%tool_dir%\manifest.json"
echo       "sizes": "192x192", >> "%tool_dir%\manifest.json"
echo       "type": "image/png" >> "%tool_dir%\manifest.json"
echo     } >> "%tool_dir%\manifest.json"
echo   ] >> "%tool_dir%\manifest.json"
echo } >> "%tool_dir%\manifest.json"

echo.
echo ✨ [%tool_dir%] フォルダを作成し、PWAファイルを設定しました！
echo 💡 あとは index.html と icon-192.png を入れるだけです。
pause