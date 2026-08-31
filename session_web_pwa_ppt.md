# This session PPT — Flutter Web + PWA only

Copy each **Slide** into PowerPoint.  
Demo app: `pwa_demo/` (separate from the Twitter clone).

```bash
cd pwa_demo
flutter run -d chrome
```

---

## Slide 1 — This session

**Flutter Web + Progressive Web Apps**

Today:

- How Flutter actually runs in the browser
- Pros / cons vs other web frameworks
- Responsive layout (resize the window)
- URLs and why **GoRouter**
- PWA: install + offline shell
- Live demo in `pwa_demo`

---

## Slide 2 — What “Flutter Web” means

You still write **Dart + widgets**.

The tool **compiles** that to files a browser understands:

- JavaScript **or** WebAssembly (Dart code)
- A **rendering engine** that draws your UI (usually on a canvas)
- HTML shell: `web/index.html` + `flutter_bootstrap.js`

You do **not** hand-write React/HTML for each screen.  
The browser is just another **device**, like Android or Windows.

```bash
flutter devices
flutter run -d chrome
flutter run -d chrome --web-port=8080
```

---

## Slide 3 — How the web builder / engine works

**Two compile paths (today):**

| Command | Dart compiler | Renderer | Role |
|---|---|---|---|
| `flutter build web` | **dart2js** → JavaScript | **CanvasKit** (Skia in Wasm) | Default, widest fallback |
| `flutter build web --wasm` | **dart2wasm** → WasmGC | **skwasm** | Faster path when the browser supports it |

`--wasm` still **also** ships the JS + CanvasKit build.  
`flutter_bootstrap.js` picks a compatible build at load time.


**Mental model:**

```
Dart widgets
    → compile (JS or Wasm)
    → Flutter engine in the page
    → Skia draws pixels (CanvasKit / skwasm)
    → one (or few) <canvas> in the DOM
```

That is why Flutter Web feels like a **canvas app**, not a classic HTML document.

```bash
flutter build web
flutter build web --wasm
```

---

## Slide 4 — First load (why it can feel “heavy”)

On first visit the browser downloads:

1. JS or Wasm of **your app**
2. **Skia / CanvasKit** (graphics engine) — often a few MB
3. Fonts, images, `FontManifest`

Then it **paints** the first frame. Later visits are faster (HTTP cache + PWA cache).

**Idea:** Flutter Web is closer to shipping a **small game engine** than shipping a 50 KB React page. Plan for that: splash, loading indicator, don’t promise “instant first paint like a blog”.

---

## Slide 5 — Advantages of Flutter Web

- **One UI codebase** with mobile / desktop (same widgets, theme, Cubit)
- **Pixel-consistent** UI (designers get the same look)
- Great for **apps**: dashboards, internal tools, admin, clone-style products
- **Hot restart** in Chrome — same workflow students already know
- Can become a **PWA** (install + cached shell) with little extra work
- Custom paint, animations, and complex layout stay in Dart

**When I would choose it:** the product is an *app that happens to open in a tab*, not a marketing site.

---

## Slide 6 — Disadvantages of Flutter Web

- **Larger first download** than React/Vue/Svelte for content sites
- **SEO / social previews** are weak: crawlers see a canvas, not real HTML text (bad for blogs, shops, landing pages)
- **Accessibility** needs extra care (screen readers + canvas)
- Some plugins are **mobile-only** (`dart:io`, some camera/maps packages)
- Text selection, Ctrl+F, “view source” do not behave like a normal website
- Wasm path needs modern browsers; others fall back to JS
- Embed in an existing WordPress/React site is awkward

**When I would not choose it:** SEO-critical public website, mostly forms + articles.

---

## Slide 7 — Flutter Web vs other frameworks

| | Flutter Web | React / Vue / Angular | Kotlin Compose Multiplatform / other |
|---|---|---|---|
| UI model | Widgets → canvas | HTML + CSS + virtual DOM | Similar “app UI” idea |
| Language | Dart | JavaScript / TypeScript | Kotlin / etc. |
| SEO | Weak | Strong if SSR | Varies |
| Look vs mobile app | Same Flutter app | You rebuild UI | Often shared UI |
| Ecosystem | pub.dev + plugins | npm, huge web ecosystem | Smaller on web |
| Typical win | App in the browser | Document / content web | Cross-platform apps |

**Honest take:**  
React is still the default for *websites*.  
Flutter is strong when the *same product* must be Android + iOS + Web **and** web is “the app in Chrome”, not “the company homepage”.

Students already know Flutter — the win this module is **leverage**, not “Flutter replaces React for everything”.

---

## Slide 8 — Responsiveness (must-have on web)

Mobile: one width. Web: user **drags the window**.

Rules:

1. Never assume 390px width
2. Use `LayoutBuilder` / `MediaQuery.sizeOf`
3. Change **structure**, not only font size (nav rail vs bottom bar, 1 vs 3 columns)
4. Set a **max content width** on desktop (don’t stretch a form to 1920px)

```dart
class Breakpoints {
  static const double phone = 600;
  static const double tablet = 1024;
}

final width = MediaQuery.sizeOf(context).width;
final isPhone = width < Breakpoints.phone;
```

**Lab:** open `pwa_demo` → `/lab` → resize Chrome. Count the cards.

---

## Slide 9 — Web routing: the problem

On mobile, `Navigator.push` is enough. Nobody sees a URL.

On web, users expect:

- `https://app.com/lab` — shareable, bookmarkable
- **Back / Forward** in the browser
- Refresh keeps the **same screen**
- Deep link from an email

`MaterialApp(home: ...)` + `push` **does not** give real URLs.  
Refresh often dumps the user on the first page. That feels broken on the web.

---

## Slide 10 — Why GoRouter

**GoRouter** is Flutter’s usual choice for web-friendly routing:

- Path = screen (`/`, `/lab`, `/about`)
- Browser history is updated
- `context.go('/lab')` vs `context.push` (replace vs stack)
- Redirects (e.g. not logged in → `/login`) later in the clone
- Works on **mobile too** — one routing style

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/lab', builder: (_, _) => const LayoutLabScreen()),
    GoRoute(path: '/about', builder: (_, _) => const AboutScreen()),
  ],
);

MaterialApp.router(routerConfig: router);
```

```dart
context.go('/lab');   // URL becomes /lab
```

**Idea:** treat every important screen as a **URL** from day one. The Twitter clone should use GoRouter before Firebase, not after.

---

## Slide 11 — What is a PWA?

**PWA = Progressive Web App**

A website that can:

- Be **installed** (icon, its own window)
- Work **offline** (at least the UI after first visit)
- Use **HTTPS** in production
- Stay a normal URL — no store required

`display: standalone` in the manifest = hide the browser chrome.

PWA ≠ “the whole backend works without internet”.  
It means: **app shell** cached. Data still needs Firestore / HTTP / local cache.

---

## Slide 12 — Flutter + PWA pieces

Already in `pwa_demo/web/`:

1. `manifest.json` — name, icons, `standalone`
2. `index.html` — `<link rel="manifest">`
3. **Service worker** — added when you **`flutter build web`** (not always obvious in `flutter run`)

```json
{
  "name": "PWA Lab",
  "short_name": "PWA Lab",
  "start_url": ".",
  "display": "standalone"
}
```

```bash
cd pwa_demo
flutter build web
python -m http.server 8080 -d build/web
```

Chrome → open `http://localhost:8080` → install → airplane mode → reload.  
UI should still open. That is the demo.

---

## Slide 13 — Session commands

```bash
cd pwa_demo
flutter pub get
flutter run -d chrome
```

Try in Chrome:

- Resize (Home + Layout lab)
- Click Layout lab — URL is `/lab`
- Browser **Back**
- Refresh on `/about`

Then:

```bash
flutter build web
# optional: flutter build web --wasm
python -m http.server 8080 -d build/web
```

---

## Slide 14 — Ideas / teaching notes

1. **App vs site:** say this out loud so students don’t ship a Flutter landing page and wonder why Google can’t read it.
2. **URLs before Firebase:** routing bugs are cheaper to fix on a 3-page demo.
3. **Breakpoints as named constants** — don’t sprinkle `600` everywhere.
4. **Two offline layers:** service worker (files) vs your data (Hive / Firestore cache).
5. **Don’t use `dart:io` on web.** Prefer `kIsWeb` only at the edges.
6. **Wasm is optional extra credit** — default `flutter build web` is enough for class.
7. Later (clone): `GoRouter` + redirect if `FirebaseAuth.currentUser == null`.

---

## Slide 15 — Recap

- Flutter Web = Dart compiled to **JS or Wasm** + **Skia** drawing in the page  
- Strong for **apps**, weak for **SEO websites**  
- **Responsive** = change layout on resize  
- **GoRouter** = real URLs + browser back  
- **PWA** = install + cached shell  

Next sessions (module plan): Firebase Auth + Twitter clone.
