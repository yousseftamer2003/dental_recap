import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/core/constants/app_config.dart';
import 'package:dental_recap/features/auth/data/repositories/auth_mock_repo_impl.dart';
import 'package:dental_recap/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:dental_recap/features/auth/data/services/auth_firebase_service.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/feed/data/repositories/feed_mock_repo_impl.dart';
import 'package:dental_recap/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:dental_recap/features/feed/data/services/feed_firebase_service.dart';
import 'package:dental_recap/features/feed/domain/repositories/feed_repository.dart';
import 'package:dental_recap/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  if (kUseMockData) {
    getIt.registerLazySingleton<AuthRepository>(() => AuthMockRepoImpl());
    getIt.registerLazySingleton<FeedRepository>(() => FeedMockRepoImpl());
  } else {
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    getIt.registerLazySingleton<AuthFirebaseService>(
      () => AuthFirebaseService(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    );
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(service: getIt<AuthFirebaseService>()),
    );
    getIt.registerLazySingleton<FeedFirebaseService>(
      () => FeedFirebaseService(
        firestore: getIt<FirebaseFirestore>(),
        auth: getIt<FirebaseAuth>(),
      ),
    );
    getIt.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(service: getIt<FeedFirebaseService>()),
    );
  }

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<FeedCubit>(
    () => FeedCubit(feedRepository: getIt<FeedRepository>()),
  );
}
