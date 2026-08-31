import 'package:flutter/material.dart';
import 'package:pwa_demo/app_router.dart';

void main() {
  runApp(const DaylineApp());
}

class DaylineApp extends StatelessWidget {
  const DaylineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dayline',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
