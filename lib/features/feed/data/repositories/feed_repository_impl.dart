import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/core/firebase/safe_firebase_call.dart';
import 'package:dental_recap/features/feed/data/services/feed_firebase_service.dart';
import 'package:dental_recap/features/feed/domain/entities/tweet_entity.dart';
import 'package:dental_recap/features/feed/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl({required FeedFirebaseService service}) : _service = service;

  final FeedFirebaseService _service;

  @override
  Future<FirebaseResult<List<TweetEntity>>> getTweets() {
    return safeFirebaseCall(
      'FeedRepository.getTweets',
      () async {
        final tweets = await _service.getTweets();
        return tweets.map((model) => model.toEntity()).toList();
      },
    );
  }

  @override
  Future<FirebaseResult<List<TweetEntity>>> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  }) {
    return safeFirebaseCall(
      'FeedRepository.addTweet',
      () async {
        final tweets = await _service.addTweet(
          authorName: authorName,
          authorHandle: authorHandle,
          text: text,
        );
        return tweets.map((model) => model.toEntity()).toList();
      },
    );
  }

  @override
  Future<FirebaseResult<List<TweetEntity>>> toggleLike(String tweetId) {
    return safeFirebaseCall(
      'FeedRepository.toggleLike',
      () async {
        final tweets = await _service.toggleLike(tweetId);
        return tweets.map((model) => model.toEntity()).toList();
      },
    );
  }
}
