import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lzma/flutter_lzma.dart';
import 'package:flutter_lzma/flutter_lzma_platform_interface.dart';
import 'package:flutter_lzma/flutter_lzma_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterLzmaPlatform
    with MockPlatformInterfaceMixin
    implements FlutterLzmaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterLzmaPlatform initialPlatform = FlutterLzmaPlatform.instance;

  test('$MethodChannelFlutterLzma is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterLzma>());
  });

  test('getPlatformVersion', () async {
    FlutterLzma flutterLzmaPlugin = FlutterLzma();
    MockFlutterLzmaPlatform fakePlatform = MockFlutterLzmaPlatform();
    FlutterLzmaPlatform.instance = fakePlatform;

    expect(await flutterLzmaPlugin.getPlatformVersion(), '42');
  });
}
