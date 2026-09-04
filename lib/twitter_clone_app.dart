import 'package:dental_recap/core/routing/app_router.dart';
import 'package:flutter/material.dart';

class TwitterCloneApp extends StatelessWidget {
  const TwitterCloneApp({super.key, required this.appRouter, required this.initialRoute});

  final AppRouter appRouter;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone',
      initialRoute: initialRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}