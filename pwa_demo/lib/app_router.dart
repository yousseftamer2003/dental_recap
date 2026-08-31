import 'package:go_router/go_router.dart';
import 'package:pwa_demo/screens/notes_screen.dart';
import 'package:pwa_demo/screens/profile_screen.dart';
import 'package:pwa_demo/screens/today_screen.dart';
import 'package:pwa_demo/widgets/app_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const TodayScreen(),
        ),
        GoRoute(
          path: '/notes',
          builder: (context, state) => const NotesScreen(),
        ),
        GoRoute(
          path: '/me',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
