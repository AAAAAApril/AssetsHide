import 'dart:convert';

import 'package:april_assets_hide/src/FileUtils.dart';
import 'package:april_assets_hide/src/Templates.dart';

import 'Assets.dart';
import 'Label.dart';
import 'PubspecConfig.dart';

class Generator {
  ///生成文件
  Future<void> generateAsync(PubspecConfig config) async {
    await output2DartFile(
      outputDir: config.outputDir,
      outputFileName: config.outputFileName,
      content: generateAssetsDartFileContent(
        assets: getJsonFiles(config.jsonsDir).map<Assets>((arbFile) {
          final Map<String, dynamic> entries =
              jsonDecode(arbFile.readAsStringSync()) as Map<String, dynamic>;
          entries.removeWhere((key, value) => value is! String);
          return Assets(
            className: getFileName(arbFile),
            labels: entries.entries
                .map<Label>(
                  (e) => Label.formMapEntry(
                    MapEntry<String, String>(e.key, e.value as String),
                  ),
                )
                .toList(),
          );
        }).toList(),
      ),
    );
  }
}
