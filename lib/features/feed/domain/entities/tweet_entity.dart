class TweetEntity {
  final String id;
  final String authorId;
  final String authorName;
  final String authorHandle;
  final String text;
  final DateTime createdAt;
  final int likes;
  final bool likedByMe;

  const TweetEntity({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.authorHandle,
    required this.text,
    required this.createdAt,
    this.likes = 0,
    this.likedByMe = false,
  });
}
