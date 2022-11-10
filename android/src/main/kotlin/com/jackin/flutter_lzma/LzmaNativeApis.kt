package com.jackin.flutter_lzma

class LzmaNativeApis {

    external fun compress(filePaths: Array<String>, targetPath: String): Boolean

    external fun compressDir(sourcePath: String, targetPath: String): Boolean

    external fun extract(archivePath: String, targetPath: String): Boolean

    companion object {
        init {
            System.loadLibrary("flutter_lzma")
        }

        val instance: LzmaNativeApis by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { LzmaNativeApis() }
    }
}