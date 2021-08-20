## 1.1.3

# 增加偏移量支持，增加生成类注释描述支持

## 1.1.0

# 增加对 int 以及 double 类型的值的支持
# 现在可以填写以下类型的 json 了
# {
#   "key1": 123,
#   "key2": 123.123,
#   "key3": "value3",
#   "key4": [
#       1, //这是需要隐藏的值，必须在第一位，支持 int double 和 String
#       "additions"  //这是其他的会添加到注释行的东西（可以添加任何类型，但会被 toString()）
#   ],
#   "key5": {
#       "value": 123, //这是需要隐藏的值，key 必须为 `value`，支持 int double 和 String 类型
#       "type": "int", //这是 value 的类型，可选的，key 必须为 `type`，如果不填，会取 value 的值的类型
#       "additions": "addition_value"
#   }
# }

## 1.0.1

# 修改使用方式：
# 在 pubspec.yaml 添加顶级节点  april_assets_hide ，这个节点与 flutter 节点平级
# 在该节点下添加  assets_json_dir 节点，用于填写资源映射 json 文件的文件夹路径，例如：lib/jsons ，这个文件夹必须实际存在
# 再次添加 generated_file_dir 节点，用于填写自动生成的文件所在文件夹，例如：lib/output ，这个文件夹如果不存在，会自动创建
# 添加第三个节点 generated_file_name ，用于填写自动生成的 Dart 文件的名字，不需要后缀，例如：AppAssets
# 最终效果如下
# april_assets_hide:
#   assets_json_dir: lib/configuration/AssetsJsons
#   generated_file_dir: lib/configuration
#   generated_file_name: AppAssets


## 1.0.0

# 使用手册：
# 1、在项目 lib 目录下创建文件夹 assets_hide
# 2、创建子文件夹 jsons ，用于放置资源路径映射文件 xxx.json 等
# 3、terminal 中运行命令：flutter pub global activate april_assets_hide   以激活插件
# 4、terminal 中运行命令：flutter pub global run april_assets_hide:generate    以生成最终代码文件
# 最终的代码会输出到 jsons 文件夹同级的 outputs 目录，其文件名为  AssetsHidden.dart
