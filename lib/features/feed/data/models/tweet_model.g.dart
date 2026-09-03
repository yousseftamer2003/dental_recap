// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetModel _$TweetModelFromJson(Map<String, dynamic> json) => TweetModel(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorHandle: json['authorHandle'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  likedByMe: json['likedByMe'] as bool? ?? false,
);

Map<String, dynamic> _$TweetModelToJson(TweetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorHandle': instance.authorHandle,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'likedByMe': instance.likedByMe,
    };
