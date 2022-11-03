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
}
