
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.18.1)

# Declares and names the project.

project("flutter_lzma")

set(CMAKE_CXX_STANDARD 11)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

add_library( # Sets the name of the library.
        flutter_lzma

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        flutter_lzma.cpp
        PLzmaSDK/src/C/7zCrc.c
        PLzmaSDK/src/C/7zCrcOpt.c
        PLzmaSDK/src/C/7zStream.c
        PLzmaSDK/src/C/Aes.c
        PLzmaSDK/src/C/AesOpt.c
        PLzmaSDK/src/C/Alloc.c
        PLzmaSDK/src/C/Bcj2.c
        PLzmaSDK/src/C/Bcj2Enc.c
        PLzmaSDK/src/C/Bra.c
        PLzmaSDK/src/C/Bra86.c
        PLzmaSDK/src/C/BraIA64.c
        PLzmaSDK/src/C/CpuArch.c
        PLzmaSDK/src/C/Delta.c
        PLzmaSDK/src/C/LzFind.c
        PLzmaSDK/src/C/LzFindMt.c
        PLzmaSDK/src/C/LzFindOpt.c
        PLzmaSDK/src/C/Lzma2Dec.c
        PLzmaSDK/src/C/Lzma2DecMt.c
        PLzmaSDK/src/C/Lzma2Enc.c
        PLzmaSDK/src/C/LzmaDec.c
        PLzmaSDK/src/C/LzmaEnc.c
        PLzmaSDK/src/C/MtCoder.c
        PLzmaSDK/src/C/Ppmd7.c
        PLzmaSDK/src/C/Ppmd7Dec.c
        PLzmaSDK/src/C/Ppmd7Enc.c
        PLzmaSDK/src/C/Sha256.c
        PLzmaSDK/src/C/Sha256Opt.c
        PLzmaSDK/src/C/Threads.c
        PLzmaSDK/src/C/Xz.c
        PLzmaSDK/src/C/XzCrc64.c
        PLzmaSDK/src/C/XzCrc64Opt.c
        PLzmaSDK/src/C/XzDec.c
        PLzmaSDK/src/C/XzEnc.c
        PLzmaSDK/src/C/XzIn.c
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zDecode.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zEncode.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zExtract.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zFolderInStream.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zHandler.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zHandlerOut.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zHeader.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zIn.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zOut.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zProperties.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zRegister.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zSpecStream.cpp
        PLzmaSDK/src/CPP/7zip/Archive/7z/7zUpdate.cpp
        PLzmaSDK/src/CPP/7zip/Archive/ArchiveExports.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/CoderMixer2.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/DummyOutStream.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/HandlerOut.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/InStreamWithCRC.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/ItemNameUtils.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/MultiStream.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Common/OutStreamWithCRC.cpp
        PLzmaSDK/src/CPP/7zip/Archive/DllExports2.cpp
        PLzmaSDK/src/CPP/7zip/Archive/LzmaHandler.cpp
        PLzmaSDK/src/CPP/7zip/Archive/SplitHandler.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarHandler.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarHandlerOut.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarHeader.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarIn.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarOut.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarRegister.cpp
        PLzmaSDK/src/CPP/7zip/Archive/Tar/TarUpdate.cpp
        PLzmaSDK/src/CPP/7zip/Archive/XzHandler.cpp
        PLzmaSDK/src/CPP/7zip/Common/CreateCoder.cpp
        PLzmaSDK/src/CPP/7zip/Common/CWrappers.cpp
        PLzmaSDK/src/CPP/7zip/Common/FileStreams.cpp
        PLzmaSDK/src/CPP/7zip/Common/FilterCoder.cpp
        PLzmaSDK/src/CPP/7zip/Common/InBuffer.cpp
        PLzmaSDK/src/CPP/7zip/Common/InOutTempBuffer.cpp
        PLzmaSDK/src/CPP/7zip/Common/LimitedStreams.cpp
        PLzmaSDK/src/CPP/7zip/Common/MethodProps.cpp
        PLzmaSDK/src/CPP/7zip/Common/OffsetStream.cpp
        PLzmaSDK/src/CPP/7zip/Common/OutBuffer.cpp
        PLzmaSDK/src/CPP/7zip/Common/ProgressUtils.cpp
        PLzmaSDK/src/CPP/7zip/Common/PropId.cpp
        PLzmaSDK/src/CPP/7zip/Common/StreamObjects.cpp
        PLzmaSDK/src/CPP/7zip/Common/StreamUtils.cpp
        PLzmaSDK/src/CPP/7zip/Common/UniqBlocks.cpp
        PLzmaSDK/src/CPP/7zip/Common/VirtThread.cpp
        PLzmaSDK/src/CPP/7zip/Compress/Bcj2Coder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/Bcj2Register.cpp
        PLzmaSDK/src/CPP/7zip/Compress/BcjCoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/BcjRegister.cpp
        PLzmaSDK/src/CPP/7zip/Compress/BranchMisc.cpp
        PLzmaSDK/src/CPP/7zip/Compress/BranchRegister.cpp
        PLzmaSDK/src/CPP/7zip/Compress/ByteSwap.cpp
        PLzmaSDK/src/CPP/7zip/Compress/CodecExports.cpp
        PLzmaSDK/src/CPP/7zip/Compress/CopyCoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/CopyRegister.cpp
        PLzmaSDK/src/CPP/7zip/Compress/DeltaFilter.cpp
        PLzmaSDK/src/CPP/7zip/Compress/Lzma2Decoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/Lzma2Encoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/Lzma2Register.cpp
        PLzmaSDK/src/CPP/7zip/Compress/LzmaDecoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/LzmaEncoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/LzmaRegister.cpp
        PLzmaSDK/src/CPP/7zip/Compress/PpmdDecoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/PpmdEncoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/PpmdRegister.cpp
        PLzmaSDK/src/CPP/7zip/Compress/XzDecoder.cpp
        PLzmaSDK/src/CPP/7zip/Compress/XzEncoder.cpp
        PLzmaSDK/src/CPP/7zip/Crypto/7zAes.cpp
        PLzmaSDK/src/CPP/7zip/Crypto/7zAesRegister.cpp
        PLzmaSDK/src/CPP/7zip/Crypto/MyAes.cpp
        PLzmaSDK/src/CPP/7zip/Crypto/MyAesReg.cpp
        PLzmaSDK/src/CPP/7zip/Crypto/RandGen.cpp
        PLzmaSDK/src/CPP/Common/CommandLineParser.cpp
        PLzmaSDK/src/CPP/Common/CRC.cpp
        PLzmaSDK/src/CPP/Common/CrcReg.cpp
        PLzmaSDK/src/CPP/Common/IntToString.cpp
        PLzmaSDK/src/CPP/Common/MyString.cpp
        PLzmaSDK/src/CPP/Common/MyWindows.cpp
        PLzmaSDK/src/CPP/Common/Sha256Reg.cpp
        PLzmaSDK/src/CPP/Common/StringConvert.cpp
        PLzmaSDK/src/CPP/Common/StringToInt.cpp
        PLzmaSDK/src/CPP/Common/TextConfig.cpp
        PLzmaSDK/src/CPP/Common/UTFConvert.cpp
        PLzmaSDK/src/CPP/Common/Wildcard.cpp
        PLzmaSDK/src/CPP/Common/XzCrc64Reg.cpp
        PLzmaSDK/src/CPP/Windows/FileDir.cpp
        PLzmaSDK/src/CPP/Windows/FileFind.cpp
        PLzmaSDK/src/CPP/Windows/FileIO.cpp
        PLzmaSDK/src/CPP/Windows/FileName.cpp
        PLzmaSDK/src/CPP/Windows/PropVariant.cpp
        PLzmaSDK/src/CPP/Windows/PropVariantConv.cpp
        PLzmaSDK/src/CPP/Windows/System.cpp
        PLzmaSDK/src/CPP/Windows/TimeUtils.cpp
        PLzmaSDK/src/plzma.cpp
        PLzmaSDK/src/plzma_base_callback.cpp
        PLzmaSDK/src/plzma_common.cpp
        PLzmaSDK/src/plzma_decoder_impl.cpp
        PLzmaSDK/src/plzma_encoder_impl.cpp
        PLzmaSDK/src/plzma_exception.cpp
        PLzmaSDK/src/plzma_extract_callback.cpp
        PLzmaSDK/src/plzma_file_utils.cpp
        PLzmaSDK/src/plzma_in_streams.cpp
        PLzmaSDK/src/plzma_item.cpp
        PLzmaSDK/src/plzma_open_callback.cpp
        PLzmaSDK/src/plzma_out_streams.cpp
        PLzmaSDK/src/plzma_path.cpp
        PLzmaSDK/src/plzma_path_utils.cpp
        PLzmaSDK/src/plzma_progress.cpp
        PLzmaSDK/src/plzma_raw_heap_memory.cpp
        PLzmaSDK/src/plzma_string.cpp
        PLzmaSDK/src/plzma_update_callback.cpp)

#add_library(libplzma
#        SHARED
#        IMPORTED)
#set_target_properties(libplzma
#        PROPERTIES
#        IMPORTED_LOCATION
#        flutter_lzma/src/${CMAKE_ANDROID_API}/libplzma.so)
#include_directories( PLzmaSDK/ )

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
        flutter_lzma

        # Links the target library to the log library
        # included in the NDK.
        ${log-lib})
