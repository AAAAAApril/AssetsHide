class Label {
  const Label({
    required this.name,
    required this.value,
  });

  factory Label.formMapEntry(MapEntry<String, String> entry) {
    return Label(name: entry.key, value: entry.value);
  }

  final String name;
  final String value;

  String generateDartField(
    String transformFunctionName,
    List<int> transformedValue,
  ) {
    return <String>[
      '  /// $name  =>  $value',
      '  static late final String $name = $transformFunctionName(const <int>${transformedValue});',
    ].join('\n');
  }
}
