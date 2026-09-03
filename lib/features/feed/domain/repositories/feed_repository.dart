import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/feed/domain/entities/tweet_entity.dart';

abstract class FeedRepository {
  Future<FirebaseResult<List<TweetEntity>>> getTweets();

  Future<FirebaseResult<List<TweetEntity>>> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  });

  Future<FirebaseResult<List<TweetEntity>>> toggleLike(String tweetId);
}
