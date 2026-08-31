# Module 6 — full module plan (not this session’s deck)

Use this file as the **20-hour Module 6 plan**: Web + PWA + Twitter clone + Firebase.

**This session’s slides (Web + PWA only):** [`session_web_pwa_ppt.md`](session_web_pwa_ppt.md)  
**This session’s demo app:** `pwa_demo/`

The slides below stay as the outline for later sessions (Firebase clone).

---

## Slide 1 — Title

**Module 6: Cross-Platform & Mid-Scale Project**

- Flutter Web
- PWA (offline apps)
- Mid-scale project: **Twitter clone + Firebase**

TECHTREK · Level 2 · 20 hours

---

## Slide 2 — Goals

By the end you can:

1. Run the app in **Chrome**
2. Explain what a **PWA** is
3. Connect **Firebase Auth + Firestore**
4. Ship **register / login + feed + post + like** with Cubit + Repo

---

## Slide 3 — Flutter Web

Same Dart widgets → HTML / JS in the browser. You do **not** rewrite the UI.

```bash
flutter devices
flutter run -d chrome
```

First time only:

```bash
flutter config --enable-web
flutter create . --platforms=web
```

---

## Slide 4 — What changes on the web

- Some plugins are **mobile-only**
- Layout must work when the **window is resized**
- Firebase Web needs `flutterfire configure` (options in `firebase_options.dart`)

```dart
import 'package:flutter/foundation.dart';

if (kIsWeb) {
  // web-only behavior
}
```

---

## Slide 5 — What is a PWA?

**PWA = Progressive Web App**

A website that can:

- Be **installed** (home screen / desktop icon)
- Open in its **own window**
- **Work offline** after the first visit
- Use one URL — no Play Store

---

## Slide 6 — How Flutter makes a PWA

1. `web/manifest.json` — name, colors, icons, `standalone`
2. `web/index.html` — links the manifest
3. **Service worker** (from `flutter build web`) — caches JS / assets

Two offline layers:

- Service worker → **app UI** still opens
- **Firestore cache** → last tweets (if you opened the feed online first)

---

## Slide 7 — Build and install

```bash
flutter build web
```

Serve `build/web`, open in Chrome → **Install** → airplane mode → reload.

```json
{
  "name": "Twitter",
  "short_name": "Twitter",
  "start_url": ".",
  "display": "standalone"
}
```

---

## Slide 8 — What we build (with Firebase)

| Feature | Firebase |
|---|---|
| Create account / Log in / Log out | **Auth** (email + password) |
| Feed, post tweet, like | **Firestore** `tweets` |

No DMs, no search. Same architecture: **UI → Cubit → Repo → Firebase**.

---

## Slide 9 — Setup in the session

**Console**

1. Create a Firebase project
2. Enable **Authentication → Email/Password**
3. Create **Firestore** database
4. Add **Web** (and Android if you need it)

**Commands**

```bash
flutter pub add firebase_core firebase_auth cloud_firestore
dart pub global activate flutterfire_cli
flutterfire configure
flutter run -d chrome
```

---

## Slide 10 — Start Firebase + architecture

```
lib/
  main.dart
  firebase_options.dart    ← generated
  features/auth  → data / logic / ui
  features/feed  → data / logic / ui
```

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(home: LoginScreen()));
}
```

Cubit does **not** import Firebase. Only the **repo** does.

---

## Slide 11 — Login Cubit (unchanged idea)

```dart
Future<void> login({
  required String email,
  required String password,
}) async {
  emit(const LoginLoading());
  try {
    final response = await _authRepo.login(
      LoginRequest(email: email, password: password),
    );
    emit(LoginSuccess(response));
  } catch (e) {
    emit(LoginFailure(e.toString()));
  }
}
```

Also call `_authRepo.register(...)` for **Create account**.

---

## Slide 12 — Auth repo = Firebase Auth

```dart
final credential = await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password);

await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);

await FirebaseAuth.instance.signOut();
```

Save profile in Firestore `users/{uid}` (name, handle, email).  
UI still uses `BlocConsumer` → go to `HomeScreen` on `LoginSuccess`.

---

## Slide 13 — Firestore: tweets

Collection `tweets`:

```
authorId, authorName, authorHandle, text, createdAt, likedBy[]
```

```dart
await tweets.add({
  'authorId': uid,
  'text': text,
  'createdAt': FieldValue.serverTimestamp(),
  'likedBy': [],
});

await tweets.orderBy('createdAt', descending: true).get();

await tweet.update({
  'likedBy': liked
      ? FieldValue.arrayRemove([uid])
      : FieldValue.arrayUnion([uid]),
});
```

---

## Slide 14 — Feed Cubit + rules (session)

```dart
BlocProvider(
  create: (_) => FeedCubit(TweetRepo())..loadTweets(),
  child: HomeView(user: user),
)
```

`loadTweets` / `addTweet` / `toggleLike` → `TweetRepo` → Firestore.

**Firestore rules (class only — not production):**

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## Slide 15 — Lab + recap

```bash
flutterfire configure
flutter run -d chrome
flutter build web
```

| Hours | Do this |
|---|---|
| 1–4 | Web + PWA |
| 5–8 | Firebase project + Auth |
| 9–20 | Firestore feed / post / like |

- **Flutter Web** = same app in the browser  
- **PWA** = installable + cached UI  
- **Firebase** = Auth + live tweets  
- Next: Module 7 — optimization, testing, publishing
