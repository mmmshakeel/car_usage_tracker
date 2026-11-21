{{flutter_js}}
{{flutter_build_config}}

// Flutter no longer supplies a caching worker, so the app owns registration of
// its standards-based PWA worker. The relative URL keeps the scope inside the
// GitHub Pages repository subpath.
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('service_worker.js');
}

_flutter.loader.load();
