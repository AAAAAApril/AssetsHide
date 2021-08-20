import 'dart:convert';

import 'Assets.dart';

String generateAssetsDartFileContent({
  required List<Assets> assets,
  required int offset,
}) {
  List<int> _toIntList(String value) {
    return utf8
        .encode(value)
        .map<int>((e) => ~e)
        .map((e) => e - offset)
        .toList();
  }
  return """
// generated code , do not change by yourself
import 'dart:convert';

String _fromIntList(List<int> value) {
  return utf8.decode(
    value
        .map<int>((e) => ~e)
        .map<int>((e) => e + ($offset))
        .toList(),
  );
}

${assets.map((e) {
    return """

${e.classDescription.map((e) => '///$e').join('\n')}
class ${e.className} {
  ${e.className}._();

${e.labels.map((e) {
      return e.generateDartField(
        '_fromIntList',
        _toIntList(e.value.stringValue),
      );
    }).join('\n\n')}
}
""";
  }).join('\n')}

"""
      .trim();
}
