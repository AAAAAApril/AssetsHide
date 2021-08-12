import 'dart:convert';

import 'Assets.dart';

List<int> _toIntList(String value) {
  return utf8.encode(value).map<int>((e) => ~e).toList();
}

String generateAssetsDartFileContent({
  required List<Assets> assets,
}) {

  return """
// generated code , do not change by yourself
import 'dart:convert';

String _fromIntList(List<int> value){
  return utf8.decode(value.map<int>((e) => ~e).toList());
}

${assets.map((e) {
    return """

class ${e.className} {
  ${e.className}._();

${e.labels.map((e) {
      return e.generateDartField('_fromIntList', _toIntList(e.value));
    }).join('\n\n')}
}
""";
  }).join('\n')}

"""
      .trim();
}
