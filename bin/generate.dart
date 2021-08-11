library assets_hide;

import 'dart:io';

import 'package:april_assets_hide/src/Generator.dart';
import 'package:april_assets_hide/src/PubspecConfig.dart';

Future<void> main(List<String> args) async {
  try {
    final Generator generator = Generator();
    final PubspecConfig config = PubspecConfig();
    await generator.generateAsync(config);
  } catch (e) {
    stderr.writeln('ERROR: Failed to generate assets files.\n$e');
    exit(2);
  }
}
