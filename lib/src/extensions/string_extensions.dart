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
}
