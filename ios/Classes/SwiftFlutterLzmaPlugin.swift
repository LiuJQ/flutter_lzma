import Flutter
import UIKit
import PLzmaSDK

public class SwiftFlutterLzmaPlugin: NSObject, FlutterPlugin, DecoderDelegate, EncoderDelegate {
    public func encoder(encoder: Encoder, path: String, progress: Double) {
        print("encoder update, path: \(path), progress: \(progress)")
    }
    
    
    public func decoder(decoder: Decoder, path: String, progress: Double) {
        print("decoder update, path: \(path), progress: \(progress)")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_lzma", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterLzmaPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break;
        case "compress":
            let arguments = call.arguments as! [String: Any]
            let filePaths = arguments["sourceFiles"] as? Array<String>
            let targetPath = arguments["destFile"] as? String
            if (filePaths == nil || filePaths!.isEmpty) {
                print("try to compress without any source, fail")
                result(nil)
                return
            }
            if (targetPath == nil) {
                print("try to compress files without target path, fail")
                result(nil)
                return
            }
            compress(filePaths: filePaths!, targetArchivePath: targetPath!, result: result)
        case "extract":
            let arguments = call.arguments as! [String: Any]
            let sourcePath = arguments["sourceFile"] as? String
            let targetPath = arguments["destDir"] as? String
            if (sourcePath == nil) {
                print("try to extract without source path, fail")
                result(nil)
                return
            }
            if (targetPath == nil) {
                print("try to extract without target dir, fail")
                result(nil)
                return
            }
            extract(archiveFilePath: sourcePath!, targetDir: targetPath!, result: result)
        default:
            print("unsupported method call: \(call.method)")
        }
        
    }
    
    public func compress(filePaths: Array<String>, targetArchivePath: String, result: @escaping FlutterResult) {
        do {
            // 1. Create a target output stream for writing archive file content.
            //  1.1. Create a target output stream with the path to an archive file.
            let archivePath = try Path(targetArchivePath)
            let archivePathInStream = try OutStream(path: archivePath)

            // 2. Create encoder with target output stream, type of archive and optional delegate.
            let encoder = try Encoder(stream: /*archiveDataInStream*/ archivePathInStream, fileType: .sevenZ, method: Method.LZMA, delegate: self)
            
            // 3. Select archive items for extracting or testing.
            //  3.1. Select all archive items.
//            let allArchiveItems = try decoder.items()
            
            //  3.2. Get the number of items, iterate items by index, filter and select items.
            let numberOfSourceFiles = filePaths.count
            for itemIndex in 0..<numberOfSourceFiles {
                try encoder.add(path: Path(filePaths[itemIndex]))
            }
            
            //  3.3 Optionaly provide the password to open/list/test/extract encrypted archive items.
            try encoder.setPassword("1234")
            let opened = try encoder.open()
            print("compress open result: \(opened)")
            
            // 4. Compress selected archive items. The compress process might be:
            let compressed = try encoder.compress()
            result(compressed)
        } catch let exception as Exception {
            print("compress exception: \(exception)")
            result(nil)
        } catch let error {
            print("compress error: \(error)")
            result(nil)
        }
    }
    
    public func extract(archiveFilePath: String, targetDir: String, result: @escaping FlutterResult) {
        do {
            // 1. Create a source input stream for reading archive file content.
            //  1.1. Create a source input stream with the path to an archive file.
            let archivePath = try Path(archiveFilePath)
            let archivePathInStream = try InStream(path: archivePath)

            //  1.2. Create a source input stream with the file content.
//            let archiveData = Data(...)
//            let archiveDataInStream = try InStream(dataNoCopy: archiveData) // also available Data(dataCopy: Data)

            // 2. Create decoder with source input stream, type of archive and optional delegate.
            let decoder = try Decoder(stream: /*archiveDataInStream*/ archivePathInStream, fileType: .sevenZ, delegate: self)
            
            //  2.1. Optionaly provide the password to open/list/test/extract encrypted archive items.
            try decoder.setPassword("1234")
            
            let opened = try decoder.open()
            
            // 3. Select archive items for extracting or testing.
            //  3.1. Select all archive items.
//            let allArchiveItems = try decoder.items()
//
//            //  3.2. Get the number of items, iterate items by index, filter and select items.
//            let numberOfArchiveItems = try decoder.count()
//            let selectedItemsDuringIteration = try ItemArray(capacity: numberOfArchiveItems)
//            let selectedItemsToStreams = try ItemOutStreamArray()
//            for itemIndex in 0..<numberOfArchiveItems {
//                let item = try decoder.item(at: itemIndex)
//                try selectedItemsDuringIteration.add(item: item)
//                try selectedItemsToStreams.add(item: item, stream: OutStream()) // to memory stream
//            }
            
            // 4. Extract or test selected archive items. The extract process might be:
            //  4.1. Extract all items to a directory. In this case, you can skip the step #3.
            let extracted = try decoder.extract(to: Path(targetDir))
            
            //  4.2. Extract selected items to a directory.
//            let extracted = try decoder.extract(items: selectedItemsDuringIteration, to: Path("path/outdir"))
            
            //  4.3. Extract each item to a custom out-stream.
            //       The out-stream might be a file or memory. I.e. extract 'item #1' to a file stream, extract 'item #2' to a memory stream(then take extacted memory) and so on.
//            let extracted = try decoder.extract(itemsToStreams: selectedItemsToStreams)
            result(extracted)
        } catch let exception as Exception {
            print("extract exception: \(exception)")
            result(nil)
        } catch let error {
            print("extract error: \(error)")
            result(nil)
        }
    }
}
