import 'package:dental_recap/core/helpers/tweet_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TweetValidator.isValid', () {
    test('rejects empty and whitespace-only text', () {
      expect(TweetValidator.isValid(''), isFalse);
      expect(TweetValidator.isValid('   '), isFalse);
    });

    test('accepts a normal tweet', () {
      expect(TweetValidator.isValid('Hello Flutter'), isTrue);
    });

    test('accepts a tweet of exactly 280 characters', () {
      expect(TweetValidator.isValid('a' * 280), isTrue);
    });

    test('rejects more than 280 characters', () {
      expect(TweetValidator.isValid('a' * 281), isFalse);
    });
  });

  group('TweetValidator.remainingChars', () {
    test('counts down from 280', () {
      expect(TweetValidator.remainingChars('Hi'), 278);
    });
  });
}
