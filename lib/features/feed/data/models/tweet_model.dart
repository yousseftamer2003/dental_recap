import 'package:dental_recap/features/feed/domain/entities/tweet_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tweet_model.g.dart';

@JsonSerializable()
class TweetModel extends TweetEntity {
  TweetModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.authorHandle,
    required super.text,
    required super.createdAt,
    super.likes = 0,
    super.likedByMe = false,
  });

  factory TweetModel.fromJson(Map<String, dynamic> json) =>
      _$TweetModelFromJson(json);

  Map<String, dynamic> toJson() => _$TweetModelToJson(this);

  TweetEntity toEntity() => TweetEntity(
        id: id,
        authorId: authorId,
        authorName: authorName,
        authorHandle: authorHandle,
        text: text,
        createdAt: createdAt,
        likes: likes,
        likedByMe: likedByMe,
      );
}
