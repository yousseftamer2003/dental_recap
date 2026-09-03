# Performance Optimization in Flutter — Slide Deck (Course Module)

Use these 9 slides in the middle of the Chirp Twitter-clone module, after students understand Clean Architecture + Cubit, and before advanced Firebase topics.

---

## Slide 1 — Title

**Performance Optimization in Flutter**

- Why smooth UI matters (60fps / 120fps)
- Performance is a feature, not an afterthought
- Goal: fast, responsive apps on real devices — not just emulators

**Speaker note:** Open with a question: "Have you ever scrolled a list and felt stutter?" Connect that feeling to frame size, rebuild cost, and network latency.

---

## Slide 2 — What "Performance" Means in Flutter

Three layers students should watch:

1. **Build cost** — how expensive widgets are to create
2. **Render cost** — how much the GPU must repaint
3. **Data cost** — Firebase/network latency and unnecessary fetches

**Benefits of optimizing early:**
- Better user retention
- Lower battery usage
- Fewer jank reports and bad reviews
- Easier scaling when lists grow (100 → 10,000 tweets)

---

## Slide 3 — The #1 Rule: Avoid Unnecessary Rebuilds

When `Cubit` emits a new state, only widgets that **listen** should update.

**Bad pattern:**
- Calling `setState` on a parent that rebuilds the entire screen

**Good pattern (used in Chirp):**
- `BlocBuilder` / `BlocListener` scoped to the part that needs data
- `listenWhen` / `buildWhen` to filter emissions

**In this project:** `HomeScreen` uses `BlocListener` for errors and `BlocBuilder` only for the tweet list — not the whole scaffold.

---

## Slide 4 — `const` Constructors

Mark widgets that never change as `const`.

```dart
const Text('Home')
const SizedBox(height: 12)
const Divider(height: 1)
```

**Benefits:**
- Flutter reuses the same widget instance
- Less allocation during scroll
- Cleaner, more intentional UI code

**Demo in Chirp:** point to `LoginScreen` header texts and `TweetCard` spacing widgets.

---

## Slide 5 — Lists: Always Prefer `ListView.builder`

**Never** put unbounded lists inside a `Column` for dynamic data.

```dart
ListView.builder(
  itemCount: tweets.length,
  itemBuilder: (context, index) => TweetCard(...),
)
```

**Benefits:**
- Builds only visible items (lazy loading)
- Memory stays stable as feed grows
- Scroll stays smooth

**Compare:** `ListView(children: [...])` builds **everything** upfront.

---

## Slide 6 — Keys & `RepaintBoundary`

**`ValueKey(tweet.id)`** on list items helps Flutter identify which row changed when likes update.

**`RepaintBoundary`** isolates repaints:

```dart
RepaintBoundary(
  child: TweetCard(...),
)
```

**Benefits:**
- Like button animation doesn't repaint the whole list
- Faster frame times during interaction

**In Chirp:** show `home_screen.dart` keys + `tweet_card.dart` RepaintBoundary.

---

## Slide 7 — Optimistic UI Updates

Don't wait for Firebase to update the UI for small actions (like/unlike).

**Flow:**
1. Update Cubit state immediately (optimistic)
2. Call repository / Firebase
3. On failure → rollback to previous state

**Benefits:**
- App feels instant
- Hides network latency
- Better perceived performance than raw round-trip time

**In Chirp:** `FeedCubit.toggleLike()` — students implement this pattern themselves.

---

## Slide 8 — Firebase-Specific Performance Tips

| Technique | Why |
|-----------|-----|
| Query with `orderBy` + limits | Don't download entire collections |
| Avoid refetching full list after every like | Use optimistic UI + targeted updates |
| Index Firestore fields used in queries | Prevents slow/failed queries at scale |
| Paginate with `startAfterDocument` | Infinite scroll without loading all tweets |

**Note for course:** Chirp keeps queries simple for teaching; mention pagination as the "next step" for production.

---

## Slide 9 — Measure, Don't Guess

**Tools:**
- **Flutter DevTools → Performance** — frame chart, rebuild stats
- **Performance Overlay** — `showPerformanceOverlay: true` (debug only)
- **`debugPrint` / `FirebaseLogger`** — trace slow operations

**Workflow:**
1. Reproduce slowness
2. Profile one screen
3. Fix the biggest bottleneck
4. Measure again

**Closing message:** Clean Architecture helps performance too — thin UI, logic in Cubit, data in repository keeps widgets small and testable.

---

## Optional Lab Checklist (Handout)

Students should verify in Chirp:

- [ ] Login screen uses scoped Bloc listeners
- [ ] Feed uses `ListView.builder`, not a static column
- [ ] Tweet rows have `ValueKey`
- [ ] `TweetCard` wrapped in `RepaintBoundary`
- [ ] Like button uses optimistic update in `FeedCubit`
- [ ] DevTools shows no red frames during scroll

---

## Mapping to Chirp Project Files

| Topic | File |
|-------|------|
| Scoped rebuilds | `features/feed/presentation/ui/screens/home_screen.dart` |
| Optimistic likes | `features/feed/presentation/cubit/feed_cubit.dart` |
| RepaintBoundary | `features/feed/presentation/ui/widgets/tweet_card.dart` |
| Firebase logging | `core/firebase/firebase_logger.dart` |
| Result pattern (no throw in UI) | `core/firebase/safe_firebase_call.dart` |
