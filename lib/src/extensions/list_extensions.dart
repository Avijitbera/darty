import 'dart:math' as math;

extension ListExtension<T> on List<T> {
  /// Returns the element at the specified index or null if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final element = list.getOrNull(1);
  /// print(element); // 2
  /// ```
  T? getOrNull(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }

  /// Returns the element at the specified index or the default value if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final element = list.getOrDefault(1, 0);
  /// print(element); // 2
  /// ```
  T getOrDefault(int index, T defaultValue) {
    if (index < 0 || index >= length) {
      return defaultValue;
    }
    return this[index];
  }

  /// Splits the list into chunks of the specified size.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final chunks = list.chunked(2);
  /// print(chunks); // [[1, 2], [3, 4], [5]]
  /// ```
  List<List<T>> chunked(int size) {
    if (size <= 0) throw ArgumentError("Size must be greater than 0");
    List<List<T>> chunks = [];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Returns a list of distinct elements based on the specified key selector.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 2, 3, 4, 4, 5];
  /// final distinctList = list.distinctBy((x) => x);
  /// print(distinctList); // [1, 2, 3, 4, 5]
  /// ```
  List<T> distinctBy<K>(K Function(T) keySelector) {
    final seen = <K>{};
    final result = <T>[];

    for (final item in this) {
      final key = keySelector(item);
      if (seen.add(key)) {
        result.add(item);
      }
    }
    return result;
  }

  /// Returns the element with the maximum value based on the specified selector.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final maxElement = list.maxBy((x) => x);
  /// print(maxElement); // 5
  /// ```
  T? maxBy<K extends Comparable>(K Function(T) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => selector(a).compareTo(selector(b)) > 0 ? a : b);
  }

  /// Returns the element with the minimum value based on the specified selector.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final minElement = list.minBy((x) => x);
  /// print(minElement); // 1
  /// ```
  T? minBy<K extends Comparable>(K Function(T) selector) {
    if (isEmpty) return null;

    return reduce((a, b) => selector(a).compareTo(selector(b)) < 0 ? a : b);
  }

  /// Groups elements by a key
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final groupedMap = list.groupBy((x) => x);
  /// print(groupedMap); // {1: [1], 2: [2], 3: [3], 4: [4], 5: [5]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final result = <K, List<T>>{};

    for (final item in this) {
      final key = keySelector(item);
      result.putIfAbsent(key, () => []).add(item);
    }

    return result;
  }

  /// Returns all possible combinations of the list.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final combinations = list.combinations();
  /// print(combinations); // [[1, 2], [1, 3], [2, 3]]
  /// ```
  List<List<T>> combinations([int length = 2]) {
    if (length < 1 || length > this.length) return [];

    List<List<T>> result = [];

    void combine(int start, List<T> current) {
      if (current.length == length) {
        result.add(List.from(current));
        return;
      }

      for (int i = start; i < this.length; i++) {
        current.add(this[i]);
        combine(i + 1, current);
        current.removeLast();
      }
    }

    combine(0, []);
    return result;
  }

  /// Returns a shuffled copy of the list.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final shuffledList = list.shuffled();
  /// print(shuffledList); // [2, 1, 3]
  /// ```
  List<T> shuffled() {
    final list = List<T>.from(this);
    list.shuffle();
    return list;
  }

  /// Returns element with most occurrences
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 2, 3, 4, 4, 5];
  /// final mostFrequent = list.mostFrequent;
  /// print(mostFrequent); // 2
  /// ```
  T? get mostFrequent {
    if (isEmpty) return null;

    final frequency = <T, int>{};
    for (final item in this) {
      frequency[item] = (frequency[item] ?? 0) + 1;
    }

    return frequency.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Returns the first element or null if empty
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final firstElement = list.firstOrNull;
  /// print(firstElement); // 1
  /// ```
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element or null if empty
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final lastElement = list.lastOrNull;
  /// print(lastElement); // 3
  /// ```
  T? get lastOrNull => isEmpty ? null : last;

  /// Removes duplicates (returns new list)
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 2, 3, 4, 4, 5];
  /// final uniqueList = list.unique;
  /// print(uniqueList); // [1, 2, 3, 4, 5]
  /// ```
  List<T> get unique {
    final seen = <T>{};
    return where(seen.add).toList();
  }

  /// Checks if list contains any element from another list
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final containsAny = list.containsAny([4, 5, 6]);
  /// print(containsAny); // false
  /// ```
  bool containsAny(Iterable<T> items) {
    for (final item in items) {
      if (contains(item)) return true;
    }
    return false;
  }

  /// Intersection of two lists
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final intersectionList = list.intersection([2, 3, 4]);
  /// print(intersectionList); // [2, 3]
  /// ```
  List<T> intersection(Iterable<T> other) {
    final otherSet = other.toSet();
    return where(otherSet.contains).toList();
  }

  /// Union of two lists
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final unionList = list.union([2, 3, 4]);
  /// print(unionList); // [1, 2, 3, 4]
  /// ```
  List<T> union(Iterable<T> other) {
    return [...this, ...other.where((item) => !contains(item))];
  }
}

extension NumListExtension on List<int> {
  /// Calculates sum of all elements
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final sumValue = list.sum;
  /// print(sumValue); // 15
  /// ```
  num get sum => fold(0, (a, b) => a + b);

  /// Calculates average of all elements
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final averageValue = list.average;
  /// print(averageValue); // 3
  /// ```
  double get average => isEmpty ? 0 : sum / length;

  /// Calculates average of all elements
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final medianValue = list.median;
  /// print(medianValue); // 3
  /// ```
  double get median {
    if (isEmpty) return 0;

    final sorted = List.from(this)..sort();
    final middle = length ~/ 2;

    if (length.isOdd) {
      return sorted[middle].toDouble();
    }

    return (sorted[middle - 1] + sorted[middle]) / 2;
  }

  /// Calculates standard deviation of all elements
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final standardDeviationValue = list.standardDeviation;
  /// print(standardDeviationValue); // 1.4142135623730951
  /// ```
  double get standardDeviation {
    if (length <= 1) return 0;

    final avg = average;
    final variance =
        map((x) => math.pow(x - avg, 2)).reduce((a, b) => a + b) / (length - 1);
    return math.sqrt(variance);
  }
}
