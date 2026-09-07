class TweetValidator {
  static const maxLength = 280;

  static bool isValid(String text) {
    final trimmed = text.trim();
    return trimmed.isNotEmpty && trimmed.length <= maxLength;
  }

  static int remainingChars(String text) => maxLength - text.length;
}
