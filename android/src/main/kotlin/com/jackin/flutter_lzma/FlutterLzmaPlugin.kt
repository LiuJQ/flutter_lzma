package com.jackin.flutter_lzma

import com.jackin.plzmasdk.PLzmaNativeApis
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterLzmaPlugin */
class FlutterLzmaPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_lzma")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val failed = { code: String, reason: String ->
            result.error(code, reason, "$code, $reason")
        }
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "compress" -> {
                val args = call.arguments as Map<*, *>?
                val filePaths = args?.get("sourceFiles") as? List<*> ?: return failed(
                    "illegal args",
                    "source files required"
                )
                val destFile = args["destFile"] as? String ?: return failed(
                    "illegal args",
                    "dest path required"
                )
                if (filePaths.isEmpty()) {
                    return failed("illegal args", "source files is empty")
                }
                if (destFile.isBlank() || destFile.isEmpty()) {
                    return failed("illegal args", "dest path is empty")
                }
                @Suppress("UNCHECKED_CAST")
                compress(filePaths as List<String>, destFile, result)
            }
            "compressDir" -> {
                val args = call.arguments as Map<*, *>?
                val sourceDir = args?.get("sourceDir") as? String ?: return failed(
                    "illegal args",
                    "source dir required"
                )
                val destFile = args["destFile"] as? String ?: return failed(
                    "illegal args",
                    "dest path required"
                )
                if (sourceDir.isBlank() || sourceDir.isEmpty()) {
                    return failed("illegal args", "source dir is empty")
                }
                if (destFile.isBlank() || destFile.isEmpty()) {
                    return failed("illegal args", "dest path is empty")
                }
                compressDir(sourceDir, destFile, result)
            }
            "extract" -> {
                val args = call.arguments as Map<*, *>?
                val sourcePath = args?.get("sourceFile") as? String ?: return failed(
                    "illegal args",
                    "source file is empty"
                )
                val destFile =
                    args["destDir"] as? String ?: return failed("illegal args", "dest dir is empty")
                if (sourcePath.isBlank() || sourcePath.isEmpty()) {
                    return failed("illegal args", "source file is empty")
                }
                if (destFile.isBlank() || destFile.isEmpty()) {
                    return failed("illegal args", "dest path is empty")
                }
                extract(sourcePath, destFile, result)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun compress(filePaths: List<String>, archivePath: String, result: Result) {
        result.success(PLzmaNativeApis.instance.compress(filePaths.toTypedArray(), archivePath))
    }

    private fun compressDir(sourcePath: String, archivePath: String, result: Result) {
        result.success(PLzmaNativeApis.instance.compressDir(sourcePath, archivePath))
    }

    private fun extract(archivePath: String, targetPath: String, result: Result) {
        result.success(PLzmaNativeApis.instance.extract(archivePath, targetPath))
    }
}
