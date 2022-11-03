import 'dart:io';

import 'package:flutter_lzma_example/file_base.dart';
import 'package:path_provider/path_provider.dart';

class FileExtract extends FileBase {
  Future<String?> testExtract({String sourceFile = "temp.7z"}) async {
    final dir = await getTemporaryDirectory();
    final cacheDir = dir.path;
    final separator = Platform.pathSeparator;
    return flutterLzmaPlugin
        .extractFile("$cacheDir$separator$sourceFile", "$cacheDir${separator}extractTemp")
        .whenComplete(() {
      printLog("testExtract files completed, ls dir st **********************");
      lsDirectory("$cacheDir${separator}extractTemp");
      printLog("testExtract files completed, ls dir ed **********************");
    });
  }
}