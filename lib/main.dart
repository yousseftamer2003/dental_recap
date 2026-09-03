import 'package:dental_recap/twitter_clone_app.dart';
import 'package:dental_recap/core/constants/app_config.dart';
import 'package:dental_recap/core/di/dependency_injection.dart';
import 'package:dental_recap/core/routing/app_router.dart';
import 'package:dental_recap/core/routing/routes.dart';
import 'package:dental_recap/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kUseMockData) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await setupGetIt();

  runApp(
    TwitterCloneApp(
      appRouter: AppRouter(),
      initialRoute: Routes.splash,
    ),
  );
}
