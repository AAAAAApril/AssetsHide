import 'dart:convert';

import 'package:april_assets_hide/src/FileUtils.dart';
import 'package:april_assets_hide/src/Templates.dart';

import 'Assets.dart';
import 'ConfigKeys.dart';
import 'Label.dart';
import 'PubspecConfig.dart';

class Generator {
  ///生成文件
  Future<void> generateAsync(PubspecConfig config) async {
    await output2DartFile(
      outputDir: config.outputDir,
      outputFileName: config.outputFileName,
      content: generateAssetsDartFileContent(
        offset: config.offsetCount,
        assets: getJsonFiles(config.jsonsDir).map<Assets>((arbFile) {
          //json 文件内容
          final Map json = jsonDecode(arbFile.readAsStringSync()) as Map;
          //移除不是 String 类型的 key
          json.removeWhere((key, value) => key is! String);
          //生成类的描述
          final dynamic desc = json[classNameKey];
          if (json.containsKey(classNameKey)) {
            json.remove(classNameKey);
          }
          //处理节点
          final List<Label> labels = <Label>[];
          for (final MapEntry entry in json.entries) {
            final Label? label = Label.formMapEntry(entry);
            if (label != null) {
              labels.add(label);
            }
          }
          //这个 json 文件对应的 类信息
          return Assets(
            className: getFileName(arbFile),
            classDescription: _getDescriptions(desc),
            labels: labels,
          );
        }).toList(),
      ),
    );
  }

  ///生成类的描述，会作为注释放在类名顶上
  List<String> _getDescriptions(final dynamic desc) {
    final List<String> description = <String>[];
    if (desc is String) {
      description.addAll(desc.split('\n'));
    } else if (desc is List) {
      desc.removeWhere((element) => element == null);
      for (final dynamic value in desc) {
        if (value is String) {
          description.addAll(value.split('\n'));
        } else {
          description.add(value.toString());
        }
      }
    }
    return description;
  }
}
