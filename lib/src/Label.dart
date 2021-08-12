class Label {
  static Label? formMapEntry(MapEntry<dynamic, dynamic> entry) {
    final dynamic key = entry.key;
    if (key is! String) {
      return null;
    }
    final dynamic value = entry.value;
    if (value == null) {
      return null;
    }
    if (value is String) {
      if (value.isNotEmpty) {
        return Label._(name: key, value: value, addition: []);
      }
    } else if (value is List) {
      value.removeWhere((element) => element == null);
      if (value.isNotEmpty) {
        //第一个值作为需要隐藏的值
        final dynamic valueResult = value.first;
        if (valueResult != null &&
            valueResult is String &&
            valueResult.isNotEmpty) {
          value.removeAt(0);
          value.removeWhere((element) => element == null);
          return Label._(name: key, value: valueResult, addition: value);
        }
      }
    } else if (value is Map) {
      value.removeWhere((key, value) => key == null || value == null);
      if (value.isNotEmpty) {
        //取出 key 为 value 的值，作为需要隐藏的值
        final dynamic valueResult = value['value'];
        if (valueResult != null &&
            valueResult is String &&
            valueResult.isNotEmpty) {
          value.remove('value');
          final List addition = [];
          for (final MapEntry entry in value.entries) {
            addition.add(entry.key);
            addition.add(entry.value);
          }
          addition.removeWhere((element) => element == null);
          return Label._(name: key, value: valueResult, addition: addition);
        }
      }
    }
    return null;
  }

  const Label._({
    required this.name,
    required this.value,
    required this.addition,
  });

  final String name;
  final String value;
  final List addition;

  String generateDartField(
    String transformFunctionName,
    List<int> transformedValue,
  ) {
    return <String>[
      ...addition.map<String>((e) => '  /// $e'),
      '  /// $value',
      '  static late final String $name = $transformFunctionName(const <int>${transformedValue});',
    ].join('\n\n');
  }
}
