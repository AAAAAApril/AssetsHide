import 'dart:convert';

import 'Assets.dart';

String generateAssetsDartFileContent({
  required List<Assets> assets,
}) {
  List<int> toIntList(String value) {
    return utf8.encode(value).map<int>((e) => ~e).toList();
  }

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
      return e.generateDartField('_fromIntList', toIntList(e.value));
    }).join('\n')}
}
""";
  }).join('\n')}

"""
      .trim();
}
