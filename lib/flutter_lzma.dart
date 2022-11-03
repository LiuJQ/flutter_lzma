
import 'flutter_lzma_platform_interface.dart';

class FlutterLzma {
  Future<String?> getPlatformVersion() {
    return FlutterLzmaPlatform.instance.getPlatformVersion();
  }

  Future<String?> compressFiles(List<String> sourcePaths, String destFile) {
    return FlutterLzmaPlatform.instance.compress(sourcePaths, destFile);
  }

  Future<String?> compressDir(String sourceDir, String destFile) {
    return FlutterLzmaPlatform.instance.compressDir(sourceDir, destFile);
  }

  Future<String?> extractFile(String sourceFile, String destDir) {
    return FlutterLzmaPlatform.instance.extract(sourceFile, destDir);
  }
}
