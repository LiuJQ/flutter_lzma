import 'dart:io';

import 'package:flutter_lzma_example/file_base.dart';
import 'package:path_provider/path_provider.dart';

class FileCompress extends FileBase {
  static const String _assetsFilesDir = "assets/files";
  static const String _file2Compress1 = "file2compress.txt";
  static const String _file2Compress2 = "ic_launcher.png";

  Future<String?> testCompress({String destFile = "temp.7z"}) async {
    await copyBundleFile(_assetsFilesDir, _file2Compress1);
    await copyBundleFile(_assetsFilesDir, _file2Compress2);
    final cacheDir = (await getTemporaryDirectory()).path;
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

  Future<String?> testCompressDir({String dir = "temp2Compress"}) async {
    await copyBundleFile(_assetsFilesDir, _file2Compress1, targetDir: dir);
    await copyBundleFile(_assetsFilesDir, _file2Compress2, targetDir: dir);
    final cacheDir = (await getTemporaryDirectory()).path;
    final separator = Platform.pathSeparator;
    return flutterLzmaPlugin
        .compressDir("$cacheDir$separator$dir", "$cacheDir$separator${dir}ed.7z")
        .whenComplete(() {
      printLog("compress dir completed, ls dir st *************************");
      lsDirectory(cacheDir);
      printLog("compress dir completed, ls dir ed *************************");
    });
  }
}
