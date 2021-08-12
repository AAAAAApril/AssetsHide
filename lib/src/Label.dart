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
    if (value is List) {
      value.removeWhere((element) => element == null);
      if (value.isNotEmpty) {
        //第一个值作为需要隐藏的值
        final Value? valueResult = Value.fromValue(value: value.first);
        if (valueResult != null) {
          value.removeAt(0);
          value.removeWhere((element) => element == null);
          return Label._(name: key, value: valueResult, addition: value);
        }
      }
    } else if (value is Map) {
      value.removeWhere((key, value) => key == null || value == null);
      if (value.isNotEmpty) {
        //取出 key 为 value 的值，作为需要隐藏的值
        final Value? valueResult = Value.fromValue(
          value: value['value'],
          valueType: value['type'] as String?,
        );
        if (valueResult != null) {
          value.remove('value');
          value.remove('type');
          final List addition = [];
          for (final MapEntry entry in value.entries) {
            addition.add(entry.key);
            addition.add(entry.value);
          }
          addition.removeWhere((element) => element == null);
          return Label._(name: key, value: valueResult, addition: addition);
        }
      }
    } else {
      final Value? valueResult = Value.fromValue(value: value);
      if (valueResult != null) {
        return Label._(name: key, value: valueResult, addition: []);
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
  final Value value;
  final List addition;

  String generateDartField(
    String transformFunctionName,
    List<int> transformedValue,
  ) {
    addition.removeWhere((element) {
      if (element is String && element.isEmpty) {
        return true;
      }
      return false;
    });
    return <String>[
      ...addition.map<String>((e) => '  /// $e'),
      '  /// ${value.value}',
      '  static late final ${value.realValueType} $name = ${value._transform("$transformFunctionName(const <int>${transformedValue})")};',
    ].join('\n');
  }
}

class Value {
  static Value? fromValue({
    required dynamic value,
    String? valueType,
  }) {
    if (value != null &&
        (value is int ||
            value is double ||
            (value is String && value.isNotEmpty))) {
      return Value._(value: value, valueType: valueType);
    }
    return null;
  }

  const Value._({
    required this.value,
    required this.valueType,
  });

  final dynamic value;
  final String? valueType;

  String get stringValue => value.toString();

  String get realValueType {
    final String type = valueType ?? value.runtimeType.toString();
    if (type == 'int') {
      return 'int';
    } else if (type == 'double') {
      return 'double';
    } else {
      return 'String';
    }
  }

  String _transform(String transformedValue) {
    if (realValueType == 'int') {
      return 'int.parse($transformedValue)';
    } else if (realValueType == 'double') {
      return 'double.parse($transformedValue)';
    } else {
      return transformedValue;
    }
  }
}
