import 'package:dental_recap/core/themes/colors.dart';
import 'package:dental_recap/features/auth/data/repos/auth_repo.dart';
import 'package:dental_recap/features/auth/logic/login_cubit.dart';
import 'package:dental_recap/features/auth/ui/widgets/login_content.dart';
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
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mainBlue,
                AppColors.secondryBlue,
                AppColors.tertiaryBlue,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/doctors_image_auth.png'),
                  const Positioned(
                    bottom: 30,
                    left: 0,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome', style: TextStyle(fontSize: 36)),
                        Text(
                          'find the best dentists near you',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Expanded(child: LoginContent()),
            ],
          ),
        ),
      ),
    );
  }
}
