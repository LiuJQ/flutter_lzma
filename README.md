# flutter_lzma

A flutter develop kit for LZMA SDK.

## Compress
```dart
final paths = <String>[
  "path for file 1",
  "path for file 2",
];
final dest = "temp.7z";
final flutterLzmaPlugin = FlutterLzma();
flutterLzmaPlugin.compressFiles(paths, dest);
```

## Extract
```dart
final source = "temp.7z";
final dest = "extractedTemp";
final flutterLzmaPlugin = FlutterLzma();
flutterLzmaPlugin.extractFile(source, dest);
```
