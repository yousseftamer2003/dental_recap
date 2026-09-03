import 'package:dental_recap/core/themes/app_colors.dart';
import 'package:dental_recap/features/auth/presentation/ui/widgets/login_content.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  'Twitter Clone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Learn Flutter with Firebase',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 24),
                Expanded(child: LoginContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
