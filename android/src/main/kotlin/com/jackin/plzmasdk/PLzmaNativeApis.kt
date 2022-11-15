package com.jackin.plzmasdk

class PLzmaNativeApis {

    external fun compress(filePaths: Array<String>, targetPath: String): Boolean

    external fun compressDir(sourcePath: String, targetPath: String): Boolean

    external fun extract(archivePath: String, targetPath: String): Boolean

    companion object {
        init {
            System.loadLibrary("plzmasdk")
        }

        val instance: PLzmaNativeApis by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { PLzmaNativeApis() }
    }
}