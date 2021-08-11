import 'dart:io';

import 'package:yaml/yaml.dart';

import 'FileUtils.dart';

class PubspecConfig {
  PubspecConfig() {
    final File? pubspecFile = getPubspecFile();
    if (pubspecFile == null) {
      throw Exception('没找到 "pubspec.yaml" 文件');
    }
    final YamlMap yamlContent = loadYaml(pubspecFile.readAsStringSync());

    final YamlMap? parentNode = yamlContent['april_assets_hide'];
    if (parentNode == null) {
      throw Exception('没找到 "april_assets_hide" 节点，该节点用于添加配置信息');
    }

    final dynamic jsons = parentNode['assets_json_dir'];
    if (jsons != null) {
      if (jsons is String) {
        jsonsDir = jsons;
      } else {
        throw Exception(
          '"assets_json_dir" 节点的值不合法，该节点应该填写一个文件路径，例如：lib/assets_json 或者 lib/AssetsJson，并确保该路径真实存在',
        );
      }
    } else {
      throw Exception(
        '缺少 "assets_json_dir" 节点，该节点用于添加资源路径的映射 json 文件夹，并确保该路径真实存在',
      );
    }

    final dynamic output = parentNode['generated_file_dir'];
    if (output != null) {
      if (output is String) {
        outputDir = output;
      } else {
        throw Exception(
          '"generated_file_dir" 节点的值不合法，该节点应该填写一个文件路径，例如：lib/assets_json_generated 或者 lib/AssetsJsonGenerated，该路径如果不存在，会自动创建',
        );
      }
    } else {
      throw Exception(
        '缺少 "generated_file_dir" 节点，该节点用于放置自动生成的文件的文件夹路径，该路径如果不存在，会自动创建',
      );
    }

    final dynamic outputFile = parentNode['generated_file_name'];
    if (outputFile != null) {
      if (outputFile is String) {
        outputFileName = outputFile;
      } else {
        throw Exception(
          '"generated_file_name" 节点的值不合法，该节点应该填写设置自动生成的 Dart 文件的名字，不需要后缀，例如：assets_generated_file 或者 AssetsGeneratedFile',
        );
      }
    } else {
      throw Exception(
        '缺少 "generated_file_name" 节点，该节点用于设置自动生成的 Dart 文件的名字，不需要后缀',
      );
    }
  }

  ///用于配置资源路径映射的文件夹
  late final String jsonsDir;

  ///自动生成的代码文件夹
  late final String outputDir;

  ///自动生成的代码文件名
  late final String outputFileName;
}
