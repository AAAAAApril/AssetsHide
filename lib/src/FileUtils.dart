import 'dart:io';
import 'package:path/path.dart' as path;

///项目跟路径
String getRootDirectoryPath() => Directory.current.path;

///获取配置文件
File? getPubspecFile() {
  var rootDirPath = getRootDirectoryPath();
  var pubspecFilePath = path.join(rootDirPath, 'pubspec.yaml');
  var pubspecFile = File(pubspecFilePath);

  return pubspecFile.existsSync() ? pubspecFile : null;
}

///获取映射文件列表
List<File> getArbFiles(String arbDir) {
  final Directory arbDirectory = Directory(path.join(
    getRootDirectoryPath(),
    arbDir,
  ));
  if (arbDirectory.existsSync()) {
    return arbDirectory
        .listSync()
        .where((element) => element is File && element.existsSync())
        .map<File>((e) => e as File)
        .toList();
  } else {
    return <File>[];
  }
}

///根据文件获取该文件的文件名
String getFileName(File file) {
  final String filePath = file.path;
  return filePath.substring(
    filePath.lastIndexOf(path.separator) + 1,
    filePath.indexOf('.'),
  );
}

///把内容输出到文件
Future<void> output2DartFile({
  required String outputDir,
  required String outputFileName,
  required String content,
}) async {
  final File outputFile = File(path.join(
    getRootDirectoryPath(),
    outputDir,
    '$outputFileName.dart',
  ));
  if (!outputFile.existsSync()) {
    await outputFile.create(recursive: true);
  }
  await outputFile.writeAsString(content);
}
