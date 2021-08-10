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

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

String _fromIntList(List<int> value){
  return utf8.decode(value.map<int>((e) => ~e).toList());
}

${assets.map((e) {
    return """

class ${e.className}{
  ${e.className}._();

${e.labels.map((e) {
      return e.generateDartField('_fromIntList', toIntList(e.value));
    }).join('\n\n')}
}

""";
  }).join('\n\n')}

"""
      .trim();
}
