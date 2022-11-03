
import 'flutter_lzma_platform_interface.dart';

class FlutterLzma {
  Future<String?> getPlatformVersion() {
    return FlutterLzmaPlatform.instance.getPlatformVersion();
  }

  Future<bool?> compressFiles(List<String> sourcePaths, String destFile) {
    return FlutterLzmaPlatform.instance.compress(sourcePaths, destFile);
  }

  Future<bool?> extractFile(String sourceFile, String destDir) {
    return FlutterLzmaPlatform.instance.extract(sourceFile, destDir);
  }
}
