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

  /// Returns the start of the day.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final startOfDay = date.startOfDay;
  /// print(startOfDay); // '2022-01-01 00:00:00.000'
  /// ```
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Returns the end of the day.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final endOfDay = date.endOfDay;
  /// print(endOfDay); // '2022-01-01 23:59:59.999'
  /// ```
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Returns the start of the week.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final startOfWeek = date.startOfWeek;
  /// print(startOfWeek); // '2022-01-01 00:00:00.000'
  /// ```
  DateTime get startOfWeek {
    final daysToSubtract = weekday - DateTime.monday;
    return subtract(Duration(days: daysToSubtract)).startOfDay;
  }

  /// Returns the end of the week.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final endOfWeek = date.endOfWeek;
  /// print(endOfWeek); // '2022-01-01 23:59:59.999'
  /// ```
  DateTime get endOfWeek {
    final daysToAdd = DateTime.sunday - weekday;
    return add(Duration(days: daysToAdd)).endOfDay;
  }

  /// Returns the start of the month.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final startOfMonth = date.startOfMonth;
  /// print(startOfMonth); // '2022-01-01 00:00:00.000'
  /// ```
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// Returns the end of the month.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final endOfMonth = date.endOfMonth;
  /// print(endOfMonth); // '2022-01-01 23:59:59.999'
  /// ```
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// Returns the start of the year.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final startOfYear = date.startOfYear;
  /// print(startOfYear); // '2022-01-01 00:00:00.000'
  /// ```
  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  /// Returns the end of the year.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final endOfYear = date.endOfYear;
  /// print(endOfYear); // '2022-12-31 23:59:59.999'
  /// ```
  DateTime get endOfYear {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }

  /// Adds the specified number of business days to the date.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final futureDate = date.addBusinessDays(5);
  /// print(futureDate); // '2022-01-01 00:00:00.000'
  /// ```
  DateTime addBusinessDays(int days) {
    if (days == 0) return this;
    var result = this;
    var remaining = days.abs();
    final step = days > 0 ? 1 : -1;
    while (remaining > 0) {
      result = result.add(Duration(days: step));
      if (result.weekday != DateTime.saturday &&
          result.weekday != DateTime.sunday) {
        remaining--;
      }
    }
    return result;
  }

  /// Returns the age of the date.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final age = date.age;
  /// print(age); // 25
  /// ```
  int get age {
    final now = DateTime.now();
    var age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  /// Returns the time ago of the date.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final timeAgo = date.timeAgo;
  /// print(timeAgo); // '25 years ago'
  /// ```
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  /// Checks if the date is between the specified start and end dates.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final isBetween = date.isBetween(DateTime.now().subtract(const Duration(days: 1)), DateTime.now().add(const Duration(days: 1)));
  /// print(isBetween); // true
  /// ```
  bool isBetween(DateTime start, DateTime end) {
    return isAfter(start) && isBefore(end) ||
        isAtSameMomentAs(start) ||
        isAtSameMomentAs(end);
  }

  /// Gets quarter of year
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final quarter = date.quarter;
  /// print(quarter); // 1
  /// ```
  int get quarter => ((month - 1) / 3).floor() + 1;

  /// Gets week number of year
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime.now();
  /// final weekNumber = date.weekNumber;
  /// print(weekNumber); // 1
  /// ```
  int get weekNumber {
    final startOfYear = DateTime(year, 1, 1);
    final days = difference(startOfYear).inDays;
    return ((days + startOfYear.weekday - 1) / 7).floor() + 1;
  }
}
