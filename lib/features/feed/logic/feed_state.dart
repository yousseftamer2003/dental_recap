import 'package:dental_recap/features/feed/data/tweet_model.dart';

abstract class FeedState {
  const FeedState();
}

class FeedInitial extends FeedState {
  const FeedInitial();
}

class FeedLoading extends FeedState {
  const FeedLoading();
}

class FeedSuccess extends FeedState {
  final List<TweetModel> tweets;

  const FeedSuccess(this.tweets);
}

class FeedFailure extends FeedState {
  final String message;

  const FeedFailure(this.message);
}
