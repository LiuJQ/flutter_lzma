
import 'flutter_lzma_platform_interface.dart';

class FlutterLzma {
  Future<String?> getPlatformVersion() {
    return FlutterLzmaPlatform.instance.getPlatformVersion();
  }
}
