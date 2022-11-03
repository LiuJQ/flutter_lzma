import 'dart:io';

import 'package:flutter_lzma_example/file_base.dart';
import 'package:path_provider/path_provider.dart';

class FileCompress extends FileBase {
  static const String _assetsFilesDir = "assets/files";
  static const String _file2Compress1 = "file2compress.txt";
  static const String _file2Compress2 = "ic_launcher.png";

  Future<bool?> testCompress({String destFile = "temp.7z"}) async {
    await copyBundleFile(_assetsFilesDir, _file2Compress1);
    await copyBundleFile(_assetsFilesDir, _file2Compress2);
    final dir = await getTemporaryDirectory();
    final cacheDir = dir.path;
    final separator = Platform.pathSeparator;
    final sourcePaths = <String>[];
    sourcePaths.add("$cacheDir$separator$_file2Compress1");
    sourcePaths.add("$cacheDir$separator$_file2Compress2");
    return flutterLzmaPlugin
        .compressFiles(sourcePaths, "$cacheDir$separator$destFile")
        .whenComplete(() {
      printLog("compress files completed, ls dir st *************************");
      lsDirectory(cacheDir);
      printLog("compress files completed, ls dir ed *************************");
    });
  }
}