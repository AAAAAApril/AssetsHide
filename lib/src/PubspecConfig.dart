class PubspecConfig {
  const PubspecConfig({
    required this.jsonsDir,
    required this.outputDir,
    required this.outputFileName,
  });

  ///用于配置资源路径映射的文件夹
  final String jsonsDir;

  ///自动生成的代码文件夹
  final String outputDir;

  ///自动生成的代码文件名
  final String outputFileName;
}
