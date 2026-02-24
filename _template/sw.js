// アプリとして認識させるためのダミープログラム（裏で動く）
self.addEventListener('install', (e) => {
  console.log('[Service Worker] Install');
});

self.addEventListener('fetch', (e) => {
  // 今回は通信をそのまま通すだけ
});
