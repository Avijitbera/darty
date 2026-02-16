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

  /// Reverses the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello';
  /// final reversed = str.reversed;
  /// print(reversed); // 'olleh'
  /// ```
  String get reversed => split('').reversed.join('');

  /// Checks if the string is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final str = '';
  /// final isNullOrEmpty = str.isNullOrEmpty;
  /// print(isNullOrEmpty); // true
  /// ```
  bool get isNullOrEmpty => isEmpty;

  /// Checks if the string is null, empty, or contains only whitespace.
  ///
  /// Example:
  /// ```dart
  /// final str = '   ';
  /// final isNullOrWhiteSpace = str.isNullOrWhiteSpace;
  /// print(isNullOrWhiteSpace); // true
  /// ```
  bool get isNullOrWhiteSpace => isEmpty || trim().isEmpty;

  /// Converts the string to camelCase.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello_world';
  /// final camelCase = str.toCamelCase;
  /// print(camelCase); // 'helloWorld'
  /// ```
  String get toCamelCase {
    if (isEmpty) return this;
    final words = split(RegExp(r'[_\s-]'));
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join('');
  }

  /// Converts the string to snake_case.
  ///
  /// Example:
  /// ```dart
  /// final str = 'helloWorld';
  /// final snakeCase = str.toSnakeCase;
  /// print(snakeCase); // 'hello_world'
  /// ```
  String get toSnakeCase {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]|[A-Z](?=[a-z])'),
      (match) => '_${match.group(0)?.toLowerCase()}',
    ).toLowerCase();
  }

  /// Converts the string to PascalCase.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello_world';
  /// final pascalCase = str.toPascalCase;
  /// print(pascalCase); // 'HelloWorld'
  /// ```
  String get toPascalCase {
    if (isEmpty) return this;
    return toCamelCase.capitalize;
  }

  /// Extracts all numbers from the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello123world456';
  /// final numbers = str.extractNumbers;
  /// print(numbers); // [123, 456]
  /// ```
  List<int> get extractNumbers {
    final matches = RegExp(r'\d+').allMatches(this);
    return matches.map((match) => int.parse(match.group(0)!)).toList();
  }

  /// Checks if the string is a valid email address.
  ///
  /// Example:
  /// ```dart
  /// final str = 'test@example.com';
  /// final isValidEmail = str.isValidEmail;
  /// print(isValidEmail); // true
  /// ```
  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegExp.hasMatch(this);
  }

  /// Checks if the string is a valid URL.
  ///
  /// Example:
  /// ```dart
  /// final str = 'https://example.com';
  /// final isValidUrl = str.isValidUrl;
  /// print(isValidUrl); // true
  /// ```
  bool get isValidUrl {
    final urlRegExp = RegExp(
      r'^(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?$',
    );
    return urlRegExp.hasMatch(this);
  }

  /// Truncates the string to the specified length.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello world';
  /// final truncated = str.truncate(5);
  /// print(truncated); // 'hello...'
  /// ```
  String truncate(int length, {String suffix = '...'}) {
    if (length <= 0) {
      throw ArgumentError('Length must be greater than 0');
    }
    if (this.length <= length) return this;
    return '$substring(0, length - suffix.length)$suffix';
  }

  /// Checks if the string contains only digits.
  ///
  /// Example:
  /// ```dart
  /// final str = '123';
  /// final isDigits = str.isDigits;
  /// print(isDigits); // true
  /// ```
  bool get isDigits {
    final digitRegExp = RegExp(r'^\d+$');
    return digitRegExp.hasMatch(this);
  }

  /// Counts the number of occurrences of a substring in the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello world';
  /// final count = str.countOccurrences('o');
  /// print(count); // 2
  /// ```
  int countOccurrences(String substring) {
    if (substring.isEmpty) return 0;
    return substring.allMatches(this).length;
  }

  /// Removes all whitespace from the string.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello world';
  /// final withoutWhiteSpaces = str.removeWhiteSpaces;
  /// print(withoutWhiteSpaces); // 'helloworld'
  /// ```
  String get removeWhiteSpaces => replaceAll(RegExp(r'\s+'), '');

  /// Converts the string to title case.
  ///
  /// Example:
  /// ```dart
  /// final str = 'hello world';
  /// final titleCase = str.toTitleCase;
  /// print(titleCase); // 'Hello World'
  /// ```
  String get toTitleCase {
    return replaceAllMapped(
      RegExp(r'\w+'),
      (match) => match.group(0)!.capitalize,
    );
  }
}
