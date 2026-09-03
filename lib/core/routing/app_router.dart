import 'package:dental_recap/core/di/dependency_injection.dart';
import 'package:dental_recap/core/helpers/session_helper.dart';
import 'package:dental_recap/core/routing/routes.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/signup_screen.dart';
import 'package:dental_recap/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:dental_recap/features/feed/presentation/ui/screens/home_screen.dart';
import 'package:dental_recap/features/feed/presentation/ui/widgets/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const _SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.home:
        final user = settings.arguments as UserEntity? ?? currentUserEntity();
        if (user == null) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider<AuthCubit>(
              create: (_) => getIt<AuthCubit>(),
              child: const LoginScreen(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<FeedCubit>(
                create: (_) => getIt<FeedCubit>()..loadTweets(),
              ),
              BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>()),
            ],
            child: HomeScreen(user: user),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}

/// First screen on app start — shows a loading skeleton, then redirects
/// to [Routes.login] or [Routes.home] based on Firebase auth session.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = currentUserEntity();
      final route = user == null ? Routes.login : Routes.home;
      Navigator.of(context).pushReplacementNamed(
        route,
        arguments: user,
      );
    });

    return Scaffold(
      body: Skeletonizer(
        enabled: true,
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemCount: 3,
          separatorBuilder: (_, index) => const Divider(height: 1),
          itemBuilder: (context, index) => TweetCard(
            tweet: TweetCardSkeleton.placeholder(index),
            onLike: () {},
          ),
        ),
      ),
    );
  }
}
