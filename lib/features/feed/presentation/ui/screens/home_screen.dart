import 'package:dental_recap/core/routing/routes.dart';
import 'package:dental_recap/core/themes/app_colors.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:dental_recap/features/feed/presentation/ui/widgets/compose_tweet_sheet.dart';
import 'package:dental_recap/features/feed/presentation/ui/widgets/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final UserEntity user;

  Future<void> _compose(BuildContext context) async {
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ComposeTweetSheet(),
    );

    if (text == null || text.isEmpty || !context.mounted) return;

    await context.read<FeedCubit>().addTweet(
          authorName: user.name,
          authorHandle: user.handle,
          text: text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        title: const Text(
          'Home',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                user.handle,
                style: const TextStyle(color: AppColors.grey),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Log out',
            onPressed: () async {
              await context.read<AuthCubit>().logout();
            },
            icon: const Icon(Icons.logout, color: AppColors.darkBlue),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FeedCubit, FeedState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                logoutSuccess: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.login,
                    (_) => false,
                  );
                },
                logoutFailure: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Skeletonizer(
                enabled: true,
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (_, index) => const Divider(height: 1),
                  itemBuilder: (context, index) => TweetCard(
                    tweet: TweetCardSkeleton.placeholder(index),
                    onLike: () {},
                  ),
                ),
              );
            }

            if (state.tweets.isEmpty) {
              return const Center(child: Text('No tweets yet. Post the first!'));
            }

            return ListView.separated(
              itemCount: state.tweets.length,
              separatorBuilder: (_, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tweet = state.tweets[index];
                return TweetCard(
                  key: ValueKey(tweet.id),
                  tweet: tweet,
                  onLike: () => context.read<FeedCubit>().toggleLike(tweet.id),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        onPressed: () => _compose(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
