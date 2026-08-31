import 'package:dental_recap/core/themes/colors.dart';
import 'package:dental_recap/features/feed/data/tweet_model.dart';
import 'package:flutter/material.dart';

class TweetCard extends StatelessWidget {
  const TweetCard({
    super.key,
    required this.tweet,
    required this.onLike,
  });

  final TweetModel tweet;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.mainBlue,
            child: Text(
              tweet.authorName.isEmpty
                  ? '?'
                  : tweet.authorName[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tweet.authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tweet.authorHandle,
                      style: const TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  tweet.text,
                  style: const TextStyle(fontSize: 15, height: 1.35),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: onLike,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tweet.likedByMe
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: tweet.likedByMe
                            ? AppColors.likeRed
                            : AppColors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${tweet.likes}',
                        style: TextStyle(
                          color: tweet.likedByMe
                              ? AppColors.likeRed
                              : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
