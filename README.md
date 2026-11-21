# Car Usage Tracker

An installable Flutter web app for recording odometer readings and monitoring a
lease-car kilometre allowance. The browser edition keeps the same tracker,
contract settings, and activity log as the native app.

## Web and offline support

- The app can be installed from a supported browser using the browser's
  **Install app** option.
- A project-owned service worker caches the complete built application for
  offline loading after the first successful visit.
- Odometer readings and contract settings are stored locally in the browser by
  Drift (using IndexedDB or the Origin-Private File System when available).
  Data does not leave the device and is retained between visits. Clearing site
  data removes the tracker data.
- `web/sqlite3.wasm` and `web/drift_worker.js` are version-matched Drift web
  runtime assets. They are required for browser storage and are intentionally
  checked into the repository.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

Build a production preview from the repository root. Replace the base path
with your repository name when testing the GitHub Pages layout:

```bash
flutter build web --release --base-href "/car_usage_tracker/"
dart tool/prepare_pwa.dart build/web
```

Serve `build/web` using a static web server (not `file://`) so WebAssembly and
service workers can load correctly.

## Deploy to GitHub Pages

The included workflow builds and publishes the app whenever `main` is updated,
and can also be started manually from the **Actions** tab.

1. In GitHub, open **Settings → Pages** for this repository.
2. Set **Source** to **GitHub Actions**.
3. Push these changes to `main`, or run **Deploy to GitHub Pages** manually.
4. Once the workflow finishes, open the URL shown by its deploy job. For this
   repository it will normally be `https://mmmshakeel.github.io/car_usage_tracker/`.

The workflow passes `--base-href "/<repository-name>/"`, so the manifest,
Flutter assets, database worker, and WebAssembly runtime load from the GitHub
Pages project subpath. Do not hard-code `/` as the base path for project pages.

## Notes

GitHub Pages cannot set the cross-origin isolation headers that enable Drift's
fastest Origin-Private File System mode. Drift automatically falls back to its
browser-safe IndexedDB storage, which remains persistent and works on modern
browsers. Avoid opening the tracker in multiple tabs on browsers that lack
shared-worker support.
