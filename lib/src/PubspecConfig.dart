import 'dart:io';

import 'package:yaml/yaml.dart';

import 'ConfigKeys.dart';
import 'FileUtils.dart';

class PubspecConfig {
  PubspecConfig() {
    final File? pubspecFile = getPubspecFile();
    if (pubspecFile == null) {
      throw Exception('没找到 "pubspec.yaml" 文件');
    }
    final YamlMap yamlContent = loadYaml(pubspecFile.readAsStringSync());

    final YamlMap? parentNode = yamlContent[configNodeName];
    if (parentNode == null) {
      throw Exception('没找到 "$configNodeName" 节点，该节点用于添加配置信息');
    }

    final dynamic jsons = parentNode[assetsJsonDirKey];
    if (jsons != null) {
      if (jsons is String) {
        jsonsDir = jsons;
      } else {
        throw Exception(
          '"$assetsJsonDirKey" 节点的值不合法，该节点应该填写一个文件路径，例如：lib/assets_json 或者 lib/AssetsJson，并确保该路径真实存在',
        );
      }
    } else {
      throw Exception(
        '缺少 "$assetsJsonDirKey" 节点，该节点用于添加资源路径的映射 json 文件夹，并确保该路径真实存在',
      );
    }

    final dynamic output = parentNode[generatedFileDirKey];
    if (output != null) {
      if (output is String) {
        outputDir = output;
      } else {
        throw Exception(
          '"$generatedFileDirKey" 节点的值不合法，该节点应该填写一个文件路径，例如：lib/assets_json_generated 或者 lib/AssetsJsonGenerated，该路径如果不存在，会自动创建',
        );
      }
    } else {
      throw Exception(
        '缺少 "$generatedFileDirKey" 节点，该节点用于放置自动生成的文件的文件夹路径，该路径如果不存在，会自动创建',
      );
    }

    final dynamic outputFile = parentNode[generatedFileNameKey];
    if (outputFile != null) {
      if (outputFile is String) {
        outputFileName = outputFile;
      } else {
        throw Exception(
          '"$generatedFileNameKey" 节点的值不合法，该节点应该填写设置自动生成的 Dart 文件的名字，不需要后缀，例如：assets_generated_file 或者 AssetsGeneratedFile',
        );
      }
    } else {
      throw Exception(
        '缺少 "$generatedFileNameKey" 节点，该节点用于设置自动生成的 Dart 文件的名字，不需要后缀',
      );
    }

    final dynamic offset = parentNode[offsetCountKey];
    if (offset != null && offset is int) {
      offsetCount = offset;
    } else {
      offsetCount = 0;
    }
  }

  ///用于配置资源路径映射的文件夹
  late final String jsonsDir;

  ///自动生成的代码文件夹
  late final String outputDir;

  ///自动生成的代码文件名
  late final String outputFileName;

  ///隐藏字符串时，对补码做的偏移量
  late final int offsetCount;
}
