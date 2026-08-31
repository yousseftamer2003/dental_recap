import 'package:dental_recap/core/themes/colors.dart';
import 'package:dental_recap/features/auth/data/auth_repo.dart';
import 'package:dental_recap/features/auth/data/user_model.dart';
import 'package:dental_recap/features/auth/ui/screens/login_screen.dart';
import 'package:dental_recap/features/feed/data/tweet_repo.dart';
import 'package:dental_recap/features/feed/logic/feed_cubit.dart';
import 'package:dental_recap/features/feed/logic/feed_state.dart';
import 'package:dental_recap/features/feed/ui/widgets/compose_tweet_sheet.dart';
import 'package:dental_recap/features/feed/ui/widgets/tweet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(TweetRepo())..loadTweets(),
      child: _HomeView(user: user),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.user});

  final UserModel user;

  Future<void> _compose(BuildContext context) async {
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ComposeTweetSheet(),
    );

    if (text == null || text.isEmpty || !context.mounted) {
      return;
    }

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
              await AuthRepo().logout();
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout, color: AppColors.darkBlue),
          ),
        ],
      ),
      body: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {
          if (state is FeedFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is FeedLoading || state is FeedInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FeedSuccess) {
            if (state.tweets.isEmpty) {
              return const Center(child: Text('No tweets yet. Post the first!'));
            }

            return ListView.separated(
              itemCount: state.tweets.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tweet = state.tweets[index];
                return TweetCard(
                  tweet: tweet,
                  onLike: () => context.read<FeedCubit>().toggleLike(tweet.id),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        onPressed: () => _compose(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
