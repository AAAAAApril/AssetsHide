import 'package:april_assets_hide/src/Label.dart';

class Assets {
  const Assets({
    required this.className,
    required this.classDescription,
    required this.labels,
  });

  final String className;
  final List<String> classDescription;
  final List<Label> labels;
}
