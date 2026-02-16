import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Checks if the date is today.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final isToday = date.isToday;
  /// print(isToday); // true
  /// ```
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is yesterday.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now().subtract(const Duration(days: 1));
  /// final isYesterday = date.isYesterday;
  /// print(isYesterday); // true
  /// ```
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if the date is tomorrow.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now().add(const Duration(days: 1));
  /// final isTomorrow = date.isTomorrow;
  /// print(isTomorrow); // true
  /// ```
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Checks if the date is in the future.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now().add(const Duration(days: 1));
  /// final isFuture = date.isFuture;
  /// print(isFuture); // true
  /// ```
  bool get isFuture => isAfter(DateTime.now());

  /// Checks if the date is in the past.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now().subtract(const Duration(days: 1));
  /// final isPast = date.isPast;
  /// print(isPast); // true
  /// ```
  bool get isPast => isBefore(DateTime.now());

  /// Formats the date using the specified pattern.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final formattedDate = date.format('yyyy-MM-dd');
  /// print(formattedDate); // '2022-01-01'
  /// ```
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
