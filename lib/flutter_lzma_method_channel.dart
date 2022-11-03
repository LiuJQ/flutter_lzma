import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_lzma_platform_interface.dart';

/// An implementation of [FlutterLzmaPlatform] that uses method channels.
class MethodChannelFlutterLzma extends FlutterLzmaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_lzma');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> compress(List<String> files, String destFile) async {
    final result = await methodChannel.invokeMethod<bool>('compress', <String, dynamic>{
      "sourceFiles": files,
      "destFile": destFile
    });
    return result == true ? destFile : null;
  }

  @override
  Future<String?> compressDir(String sourceDir, String destFile) async {
    final result = await methodChannel.invokeMethod<bool>('compressDir', <String, dynamic>{
      "sourceDir": sourceDir,
      "destFile": destFile
    });
    return result == true ? destFile : null;
  }

  @override
  Future<String?> extract(String sourceFile, String destDir) async {
    final result = await methodChannel.invokeMethod<bool>('extract', <String, dynamic>{
      "sourceFile": sourceFile,
      "destDir": destDir
    });
    return result == true ? destDir : null;
  }
}
