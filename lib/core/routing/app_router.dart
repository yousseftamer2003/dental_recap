import 'package:dental_recap/core/di/dependency_injection.dart';
import 'package:dental_recap/core/helpers/extensions.dart';
import 'package:dental_recap/core/helpers/session_helper.dart';
import 'package:dental_recap/core/routing/routes.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/signup_screen.dart';
import 'package:dental_recap/features/feed/presentation/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const _SplashScreen());
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text('Route not found')),
        );
    }
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = getCurrentUser();
      final route = user != null ? Routes.home : Routes.login;
      context.pushReplacementNamed(route);
    });
    return Scaffold(
      body: Skeletonizer(
        enabled: true,
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 50),
          itemCount: 3,
          itemBuilder: (context, index) => const Card(
            child: ListTile(
              title: Text('Hello'),
              subtitle: Text('New Post'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      )
    );
  }
}
