import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_lzma_method_channel.dart';

abstract class FlutterLzmaPlatform extends PlatformInterface {
  /// Constructs a FlutterLzmaPlatform.
  FlutterLzmaPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLzmaPlatform _instance = MethodChannelFlutterLzma();

  /// The default instance of [FlutterLzmaPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLzma].
  static FlutterLzmaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLzmaPlatform] when
  /// they register themselves.
  static set instance(FlutterLzmaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> compress(List<String> files, String destFile) {
    throw UnimplementedError('compress() has not been implemented.');
  }

  Future<bool?> extract(String sourceFile, String destDir) {
    throw UnimplementedError('extract() has not been implemented.');
  }
}
