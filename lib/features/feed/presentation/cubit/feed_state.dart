part of 'feed_cubit.dart';

@freezed
abstract class FeedState with _$FeedState {
  const factory FeedState({
    @Default([]) List<TweetEntity> tweets,
    @Default(true) bool isLoading,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = _FeedState;
}
