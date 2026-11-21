const cacheName = 'car-usage-tracker-__BUILD_ID__';
const cachePrefix = 'car-usage-tracker-';
const precacheUrls = __PRECACHE_URLS__;

function atAppRoot(path) {
  return new URL(path, self.registration.scope).toString();
}

async function precacheApp() {
  const cache = await caches.open(cacheName);
  await cache.addAll([atAppRoot('./'), ...precacheUrls.map(atAppRoot)]);
}

self.addEventListener('install', (event) => {
  event.waitUntil(precacheApp().then(() => self.skipWaiting()));
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(
          keys
              .filter((key) => key.startsWith(cachePrefix) && key !== cacheName)
              .map((key) => caches.delete(key)),
        ),
      )
      .then(() => self.clients.claim()),
  );
});

self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;

  event.respondWith(
    fetch(event.request)
        .then((response) => {
          if (response.ok && new URL(event.request.url).origin === self.location.origin) {
            const cachedResponse = response.clone();
            caches.open(cacheName).then((cache) => cache.put(event.request, cachedResponse));
          }
          return response;
        })
        .catch(() =>
          caches.match(event.request).then((cached) => {
            if (cached) return cached;
            if (event.request.mode === 'navigate') {
              return caches.match(atAppRoot('./'));
            }
            return Response.error();
          }),
        ),
  );
});
