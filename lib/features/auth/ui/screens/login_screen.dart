import 'package:dental_recap/core/themes/colors.dart';
import 'package:dental_recap/features/auth/data/auth_repo.dart';
import 'package:dental_recap/features/auth/logic/login_cubit.dart';
import 'package:dental_recap/features/auth/ui/widgets/login_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(AuthRepo()),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkBlue, AppColors.mainBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Column(
              children: [
                SizedBox(height: 32),
                Icon(Icons.flutter_dash, color: Colors.white, size: 64),
                SizedBox(height: 12),
                Text(
                  'Chirp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A simple Twitter clone',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 24),
                Expanded(child: LoginContentWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
