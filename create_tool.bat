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
mkdir %tool_dir%

:: sw.jsの自動生成（キャッシュ名もツールごとに自動で分ける設定）
(
echo const CACHE_NAME = '%tool_dir%-v1'^;
echo const urlsToCache = [ './', './index.html', './manifest.json', './icon-192.png' ]^;
echo.
echo self.addEventListener('install', event =^> {
echo   event.waitUntil(caches.open(CACHE_NAME).then(cache =^> cache.addAll(urlsToCache)))^;
echo })^;
echo.
echo self.addEventListener('fetch', event =^> {
echo   event.respondWith(caches.match(event.request).then(response =^> response ^|^| fetch(event.request)))^;
echo })^;
) > %tool_dir%\sw.js

:: manifest.jsonの自動生成（入力された名前を埋め込む）
(
echo {
echo   "name": "%app_name%",
echo   "short_name": "%short_name%",
echo   "start_url": "./",
echo   "display": "standalone",
echo   "background_color": "#ffffff",
echo   "theme_color": "#1565c0",
echo   "icons": [
echo     {
echo       "src": "icon-192.png",
echo       "sizes": "192x192",
echo       "type": "image/png"
echo     }
echo   ]
echo }
) > %tool_dir%\manifest.json

echo.
echo ✨ [%tool_dir%] フォルダを作成し、PWAファイルを設定しました！
echo 💡 あとは index.html と icon-192.png を入れるだけです。
pause