import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_lzma/flutter_lzma.dart';
import 'package:flutter_lzma_example/file_compress.dart';
import 'package:flutter_lzma_example/file_extract.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterLzmaPlugin = FlutterLzma();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterLzmaPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Running on: $_platformVersion\n'),
              buildCompress(),
              buildCompressDir(),
              buildExtract(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompress() {
    return TextButton(onPressed: () => FileCompress().testCompress(), child: const Text("Test Compress"));
  }

  Widget buildCompressDir() {
    return TextButton(onPressed: () => FileCompress().testCompressDir(), child: const Text("Test Compress Dir"));
  }

  Widget buildExtract() {
    return TextButton(onPressed: () => FileExtract().testExtract(), child: const Text("Test Extract"));
  }
}
