extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello';
  /// final capitalized = str.capitalize;
  /// print(capitalized); // 'Hello'
  /// ```
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello world';
  /// final capitalized = str.capitalizeWords;
  /// print(capitalized); // 'Hello World'
  /// ```
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }
}
