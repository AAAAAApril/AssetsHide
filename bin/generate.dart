library assets_hide;

import 'dart:io';

import 'package:april_assets_hide/src/FileUtils.dart';
import 'package:april_assets_hide/src/Generator.dart';
import 'package:april_assets_hide/src/PubspecConfig.dart';
import 'package:yaml/yaml.dart' as yaml;

Future<void> main(List<String> args) async {
  try {
    final Generator generator = Generator();

    final File? pubspecFile = getPubspecFile();
    if (pubspecFile == null) {
      throw Exception("没找到 'pubspec.yaml' 文件");
    }
    final config = yaml.loadYaml(
      pubspecFile.readAsStringSync(),
    )['april_assets_hide'];

    if (config == null) return;

    await generator.generateAsync(PubspecConfig(
      arbDir: 'lib/assets_hide/arbs',
      outputDir: 'lib/assets_hide/outputs',
      outputFileName: 'AssetsHidden',
    ));
  } catch (e) {
    stderr.writeln('ERROR: Failed to generate assets files.\n$e');
    exit(2);
  }
}
