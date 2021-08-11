## 1.0.1

# 修改使用方式：
# 在 pubspec.yaml 添加顶级节点  april_assets_hide ，这个节点与 flutter 节点平级
# 在该节点下添加  assets_json_dir 节点，用于填写资源映射 json 文件的文件夹路径，例如：lib/jsons ，这个文件夹必须实际存在
# 再次添加 generated_file_dir 节点，用于填写自动生成的文件所在文件夹，例如：lib/output ，这个文件夹如果不存在，会自动创建
# 添加第三个节点 generated_file_name ，用于填写自动生成的 Dart 文件的名字，不需要后缀，例如：AppAssets
# 最终效果如下
april_assets_hide:
  assets_json_dir: lib/configuration/AssetsJsons
  generated_file_dir: lib/configuration
  generated_file_name: AppAssets


## 1.0.0

# 使用手册：
# 1、在项目 lib 目录下创建文件夹 assets_hide
# 2、创建子文件夹 jsons ，用于放置资源路径映射文件 xxx.json 等
# 3、terminal 中运行命令：flutter pub global activate april_assets_hide   以激活插件
# 4、terminal 中运行命令：flutter pub global run april_assets_hide:generate    以生成最终代码文件
# 最终的代码会输出到 jsons 文件夹同级的 outputs 目录，其文件名为  AssetsHidden.dart
