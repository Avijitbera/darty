extension MapExtension<K, V> on Map<K, V> {
  /// Returns the value for the specified key or the default value if the key is not present.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2};
  /// final value = map.getOrDefault('a', 0);
  /// print(value); // 1
  /// ```
  V? getOrDefault(K key, V? defaultValue) {
    return containsKey(key) ? this[key] : defaultValue;
  }

  /// Merges the specified map with the current map.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2};
  /// final mergedMap = map.merge({'c': 3});
  /// print(mergedMap); // {'a': 1, 'b': 2, 'c': 3}
  /// ```
  Map<K, V> merge(Map<K, V> other) {
    return {...this, ...other};
  }

  /// Returns a new map containing only the specified keys.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final pickedMap = map.pick(['a', 'b']);
  /// print(pickedMap); // {'a': 1, 'b': 2}
  /// ```
  Map<K, V> pick(Iterable<K> keys) {
    final result = <K, V>{};
    for (final key in keys) {
      if (containsKey(key)) {
        result[key] = this[key] as V;
      }
    }
    return result;
  }

  /// Returns a new map containing all keys except the specified keys.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final omittedMap = map.omit(['a', 'b']);
  /// print(omittedMap); // {'c': 3}
  /// ```
  Map<K, V> omit(Iterable<K> keys) {
    final keySet = keys.toSet();
    return Map.fromEntries(entries.where((e) => !keySet.contains(e.key)));
  }

  /// Returns a new map with the values transformed.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final transformedMap = map.mapValues((value) => value * 2);
  /// print(transformedMap); // {'a': 2, 'b': 4, 'c': 6}
  /// ```
  Map<K, R> mapValues<R>(R Function(V value) transform) {
    return map((key, value) => MapEntry(key, transform(value)));
  }

  /// Returns a new map with the keys transformed.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final transformedMap = map.mapKeys((key) => key.toUpperCase());
  /// print(transformedMap); // {'A': 1, 'B': 2, 'C': 3}
  /// ```
  Map<R, V> mapKeys<R>(R Function(K key) transform) {
    return map((key, value) => MapEntry(transform(key), value));
  }

  /// Returns a new map with the keys and values inverted.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final invertedMap = map.invert();
  /// print(invertedMap); // {1: 'a', 2: 'b', 3: 'c'}
  /// ```
  Map<V, K> invert() {
    return map((key, value) => MapEntry(value, key));
  }

  /// Returns a list of keys.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final keysList = map.keysList;
  /// print(keysList); // ['a', 'b', 'c']
  /// ```
  List<K> get keysList => keys.toList();

  /// Returns a list of values.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final valuesList = map.valuesList;
  /// print(valuesList); // [1, 2, 3]
  /// ```
  List<V> get valuesList => values.toList();

  /// Returns true if the map is null or empty.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final isNullOrEmpty = map.isNullOrEmpty;
  /// print(isNullOrEmpty); // false
  /// ```
  bool get isNullOrEmpty => isEmpty;

  /// Updates the value for the specified key or adds it if it doesn't exist.
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// map.updateOrAdd('a', (value) => value + 1);
  /// print(map); // {'a': 2, 'b': 2, 'c': 3}
  /// ```
  void updateOrAdd(
    K key,
    V Function(V existing) update, {
    required V ifAbsent,
  }) {
    if (containsKey(key)) {
      this[key] = update(this[key] as V);
    } else {
      this[key] = ifAbsent;
    }
  }

  /// Returns a new map with keys transformed to lowercase (for string keys)
  ///
  /// Example:
  /// ```dart
  /// final map = {'a': 1, 'b': 2, 'c': 3};
  /// final lowerCaseMap = map.lowerCaseKeys();
  /// print(lowerCaseMap); // {'a': 1, 'b': 2, 'c': 3}
  /// ```
  Map<String, V> lowerCaseKeys() {
    if (K != String) {
      throw StateError('lowerCaseKeys can only be used on Map<String, V>');
    }

    final result = <String, V>{};
    forEach((key, value) {
      result[(key as String).toLowerCase()] = value;
    });
    return result;
  }
}
