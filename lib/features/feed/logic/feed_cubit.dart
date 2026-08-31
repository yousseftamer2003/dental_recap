import 'package:dental_recap/features/feed/data/tweet_repo.dart';
import 'package:dental_recap/features/feed/logic/feed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(this._tweetRepo) : super(const FeedInitial());

  final TweetRepo _tweetRepo;

  Future<void> loadTweets() async {
    emit(const FeedLoading());
    try {
      final tweets = await _tweetRepo.getTweets();
      emit(FeedSuccess(tweets));
    } catch (e) {
      emit(FeedFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  }) async {
    if (text.trim().isEmpty) {
      emit(const FeedFailure('Tweet cannot be empty.'));
      return;
    }

    emit(const FeedLoading());
    try {
      final tweets = await _tweetRepo.addTweet(
        authorName: authorName,
        authorHandle: authorHandle,
        text: text,
      );
      emit(FeedSuccess(tweets));
    } catch (e) {
      emit(FeedFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> toggleLike(String tweetId) async {
    try {
      final tweets = await _tweetRepo.toggleLike(tweetId);
      emit(FeedSuccess(tweets));
    } catch (e) {
      emit(FeedFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
