import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lzma/flutter_lzma.dart';
import 'package:path_provider/path_provider.dart';

class FileBase {
  @protected
  final flutterLzmaPlugin = FlutterLzma();

  Future copyBundleFile(String sourceDir, String assetsFile) async {
    final dir = await getTemporaryDirectory();
    final cacheDir = dir.path;
    final libFile = File("$cacheDir/$assetsFile");

    // 从rootBundle加载出assets资源
    final data = await rootBundle.load("$sourceDir${Platform.pathSeparator}$assetsFile");
    final createFile = await libFile.create();
    final writeFile = await createFile.open(mode: FileMode.write);
    await writeFile.writeFrom(Uint8List.view(data.buffer));
  }

  void lsDirectory(String dir, {bool recursive = false}) {
    var directory = Directory(dir);
    List<FileSystemEntity> fileList = directory.listSync();
    var dirSize = fileList.length;
    printLog("dir: $dir has files: $dirSize");

    for (FileSystemEntity f in fileList) {
      if (FileSystemEntity.isDirectorySync(f.path)) {
        if (!recursive) continue;
        lsDirectory(f.path);
      } else {
        printLog(
            "file: ${f.path.substring(f.path.lastIndexOf(Platform.pathSeparator) + 1)}, length: ${File(f.path).lengthSync()}");
      }
    }
  }

  void printLog(String msg, {String? tag}) {
    if (kDebugMode) {
      print("[${tag ?? "FileBase"}] ======> $msg");
    }
  }
}
