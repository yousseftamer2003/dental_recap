import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/feed/domain/entities/tweet_entity.dart';
import 'package:dental_recap/features/feed/domain/repositories/feed_repository.dart';

/// In-memory feed for UI preview.
class FeedMockRepoImpl implements FeedRepository {
  FeedMockRepoImpl() {
    _tweets.addAll(_seedTweets);
  }

  final List<TweetEntity> _tweets = [];

  static final List<TweetEntity> _seedTweets = [
    TweetEntity(
      id: '1',
      authorId: 'a1',
      authorName: 'Flutter Dev',
      authorHandle: '@flutterdev',
      text: 'Welcome to Twitter Clone! This is mock data — no Firebase needed.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 42,
      likedByMe: false,
    ),
    TweetEntity(
      id: '2',
      authorId: 'a2',
      authorName: 'Course Student',
      authorHandle: '@student',
      text: 'Clean Architecture + Cubit + Freezed = happy codebase.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      likes: 18,
      likedByMe: true,
    ),
    TweetEntity(
      id: '3',
      authorId: 'a3',
      authorName: 'Firebase Later',
      authorHandle: '@firebase',
      text: 'Run flutterfire configure when you are ready for the real backend.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      likes: 7,
      likedByMe: false,
    ),
  ];

  @override
  Future<FirebaseResult<List<TweetEntity>>> getTweets() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return FirebaseResult.success(List.unmodifiable(_tweets));
  }

  @override
  Future<FirebaseResult<List<TweetEntity>>> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _tweets.insert(
      0,
      TweetEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorId: 'mock-user',
        authorName: authorName,
        authorHandle: authorHandle,
        text: text.trim(),
        createdAt: DateTime.now(),
      ),
    );
    return FirebaseResult.success(List.unmodifiable(_tweets));
  }

  @override
  Future<FirebaseResult<List<TweetEntity>>> toggleLike(String tweetId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _tweets.indexWhere((tweet) => tweet.id == tweetId);
    if (index == -1) {
      return FirebaseResult.success(List.unmodifiable(_tweets));
    }

    final tweet = _tweets[index];
    final liked = !tweet.likedByMe;
    _tweets[index] = TweetEntity(
      id: tweet.id,
      authorId: tweet.authorId,
      authorName: tweet.authorName,
      authorHandle: tweet.authorHandle,
      text: tweet.text,
      createdAt: tweet.createdAt,
      likes: liked ? tweet.likes + 1 : (tweet.likes > 0 ? tweet.likes - 1 : 0),
      likedByMe: liked,
    );
    return FirebaseResult.success(List.unmodifiable(_tweets));
  }
}
