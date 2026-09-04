import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:dental_recap/features/auth/data/services/firebase_auth_service.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async{

  getIt.registerLazySingleton<FirebaseAuth>(
    ()=> FirebaseAuth.instance,
  );

  getIt.registerLazySingleton<FirebaseFirestore>(
    ()=> FirebaseFirestore.instance,
  );


  getIt.registerLazySingleton<FirebaseAuthService>(
    ()=> FirebaseAuthService(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    ()=> AuthRepoImpl(
      authService: getIt<FirebaseAuthService>(),
      ),
  );

  getIt.registerFactory<AuthCubit>(
    ()=> AuthCubit(authRepository: getIt<AuthRepository>()),
  );


}