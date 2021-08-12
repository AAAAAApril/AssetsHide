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
          final List<Label> labels = <Label>[];
          for (final MapEntry entry
              in (jsonDecode(arbFile.readAsStringSync()) as Map).entries) {
            final Label? label = Label.formMapEntry(entry);
            if (label != null) {
              labels.add(label);
            }
          }
          return Assets(className: getFileName(arbFile), labels: labels);
        }).toList(),
      ),
    );
  }
}
