import 'package:bloc/bloc.dart';
import 'package:dental_recap/core/constants/strings.dart';
import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/feed/domain/entities/tweet_entity.dart';
import 'package:dental_recap/features/feed/domain/repositories/feed_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_state.dart';
part 'feed_cubit.freezed.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit({required FeedRepository feedRepository})
      : _feedRepository = feedRepository,
        super(const FeedState());

  final FeedRepository _feedRepository;

  Future<void> loadTweets() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _feedRepository.getTweets();
    result.when(
      success: (tweets) => emit(
        state.copyWith(tweets: tweets, isLoading: false),
      ),
      failure: (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.displayMessage.isNotEmpty
              ? error.displayMessage
              : FirebaseErrorConstants.defaultError,
        ),
      ),
    );
  }

  Future<void> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  }) async {
    if (text.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Tweet cannot be empty.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final result = await _feedRepository.addTweet(
      authorName: authorName,
      authorHandle: authorHandle,
      text: text,
    );
    result.when(
      success: (tweets) => emit(
        state.copyWith(tweets: tweets, isSubmitting: false),
      ),
      failure: (error) => emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: error.displayMessage.isNotEmpty
              ? error.displayMessage
              : FirebaseErrorConstants.defaultError,
        ),
      ),
    );
  }

  /// Optimistic update: UI changes instantly, then syncs with Firebase.
  Future<void> toggleLike(String tweetId) async {
    final index = state.tweets.indexWhere((tweet) => tweet.id == tweetId);
    if (index == -1) return;

    final tweet = state.tweets[index];
    final optimisticLiked = !tweet.likedByMe;
    final optimisticCount = optimisticLiked
        ? tweet.likes + 1
        : (tweet.likes > 0 ? tweet.likes - 1 : 0);

    _updateTweetAt(
      index,
      _copyTweet(
        tweet,
        likedByMe: optimisticLiked,
        likes: optimisticCount,
      ),
    );

    final result = await _feedRepository.toggleLike(tweetId);
    result.when(
      success: (tweets) => emit(state.copyWith(tweets: tweets)),
      failure: (_) => _updateTweetAt(index, tweet),
    );
  }

  void _updateTweetAt(int index, TweetEntity tweet) {
    final updated = List<TweetEntity>.from(state.tweets);
    updated[index] = tweet;
    emit(state.copyWith(tweets: updated));
  }

  TweetEntity _copyTweet(
    TweetEntity tweet, {
    bool? likedByMe,
    int? likes,
  }) {
    return TweetEntity(
      id: tweet.id,
      authorId: tweet.authorId,
      authorName: tweet.authorName,
      authorHandle: tweet.authorHandle,
      text: tweet.text,
      createdAt: tweet.createdAt,
      likes: likes ?? tweet.likes,
      likedByMe: likedByMe ?? tweet.likedByMe,
    );
  }
}
