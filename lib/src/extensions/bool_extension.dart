extension BoolExtension on bool {
  /// Converts boolean to integer.
  ///
  /// Example:
  /// ```dart
  /// final boolValue = true;
  /// final intValue = boolValue.toInt;
  /// print(intValue); // 1
  /// ```
  int get toInt => this ? 1 : 0;

  /// Converts boolean to yes/no string.
  ///
  /// Example:
  /// ```dart
  /// final boolValue = true;
  /// final yesNoValue = boolValue.toYesNo(yes: 'yes', no: 'no');
  /// print(yesNoValue); // 'yes'
  /// ```
  String toYesNo({String yes = 'yes', String no = 'no'}) => this ? yes : no;

  /// Converts boolean to on/off string.
  ///
  /// Example:
  /// ```dart
  /// final boolValue = true;
  /// final onOffValue = boolValue.toOnOff(on: 'on', off: 'off');
  /// print(onOffValue); // 'on'
  /// ```
  String toOnOff({String on = 'on', String off = 'off'}) => this ? on : off;

  /// Converts boolean to enabled/disabled string.
  ///
  /// Example:
  /// ```dart
  /// final boolValue = true;
  /// final enabledDisabledValue = boolValue.toEnabledDisabled(
  ///   enabled: 'enabled',
  ///   disabled: 'disabled',
  /// );
  /// print(enabledDisabledValue); // 'enabled'
  /// ```
  String toEnabledDisabled({
    String enabled = 'enabled',
    String disabled = 'disabled',
  }) => this ? enabled : disabled;

  /// Converts boolean to not boolean.
  ///
  /// Example:
  /// ```dart
  /// final boolValue = true;
  /// final notValue = boolValue.not;
  /// print(notValue); // false
  /// ```
  bool get not => !this;
}
