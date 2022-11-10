#include <jni.h>
#include <android/log.h>
#include <string>
#include "PLzmaSDK/libplzma.hpp"

using namespace std;
using namespace plzma;

// Write C++ code here.
//
// Do not forget to dynamically load the C++ library into your application.
//

class PLzmaProgressDelegate: public ProgressDelegate {
public:
    void onProgress(void * _Nullable context, const String &path, const double progress) override {
        std::string message = "Path: ";
        message.append(path.utf8());
        message.append(", progress: ");
        message.append(to_string(progress));
        __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "%s", message.c_str());
    }
};

extern "C"
JNIEXPORT jboolean
Java_com_jackin_flutter_1lzma_LzmaNativeApis_compress(JNIEnv *env, jobject thiz, jobjectArray file_paths,
                                                      jstring target_path) {
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "Native compress");
    // 1. Create output stream for writing archive's file content.
    //  1.1. Using file path.
    const char *dest_path = env->GetStringUTFChars(target_path, nullptr);
    const auto archivePathOutStream = makeSharedOutStream(Path(dest_path));
    // release string utf chars
    env->ReleaseStringUTFChars(target_path, dest_path);
    // 2. Create encoder with output stream, type of the archive, compression method and optional progress delegate.
    auto encoder = makeSharedEncoder(archivePathOutStream, plzma_file_type_7z, plzma_method_LZMA2);
    auto * _plzma_progress_delegate = new PLzmaProgressDelegate();
    encoder->setProgressDelegate(_plzma_progress_delegate);
    //  2.1. Optionaly provide the password in case of header and/or content encryption.
//    encoder->setPassword("1234");
    //  2.2. Setup archive properties.
//    encoder->setShouldEncryptHeader(true);   // use this option with password.
//    encoder->setShouldEncryptContent(true);  // use this option with password.
    encoder->setCompressionLevel(9);
    // 3. Add content for archiving.
    int stringCount = env->GetArrayLength(file_paths);
    for (int i=0; i<stringCount; i++) {
        auto string = (jstring) (env->GetObjectArrayElement(file_paths, i));
        const char *rawString = env->GetStringUTFChars(string, nullptr);
        encoder->add(Path(rawString));
        // Don't forget to call `ReleaseStringUTFChars` when you're done.
        env->ReleaseStringUTFChars(string, rawString);
    }
    //  3.1. Single file path with optional path inside the archive.
//    encoder->add(Path("dir/my_file1.txt"));  // store as "dir/my_file1.txt", as is.
//    encoder->add(Path("dir/my_file2.txt"), 0, Path("renamed_file2.txt")); // store as "renamed_file2.txt"
    // 4. Open.
    bool opened = encoder->open();
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "compress encoder open result: %s", opened ? "true" : "false");

    // 4. Compress.
    bool compressed = encoder->compress();
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "compress encoder compress result: %s", compressed ? "true" : "false");
    return compressed;
}

extern "C"
JNIEXPORT jboolean
Java_com_jackin_flutter_1lzma_LzmaNativeApis_compressDir(JNIEnv *env, jobject thiz,
                                                         jstring source_path, jstring target_path) {
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "Native compressDir");
    // 1. Create output stream for writing archive's file content.
    //  1.1. Using file path.
    const char *dest_path = env->GetStringUTFChars(target_path, nullptr);
    const auto archivePathOutStream = makeSharedOutStream(Path(dest_path));
    // release string utf chars
    env->ReleaseStringUTFChars(target_path, dest_path);
    // 2. Create encoder with output stream, type of the archive, compression method and optional progress delegate.
    auto encoder = makeSharedEncoder(archivePathOutStream, plzma_file_type_7z, plzma_method_LZMA2);
    auto * _plzma_progress_delegate = new PLzmaProgressDelegate();
    encoder->setProgressDelegate(_plzma_progress_delegate);
    //  2.1. Optionaly provide the password in case of header and/or content encryption.
//    encoder->setPassword("1234");
    //  2.2. Setup archive properties.
//    encoder->setShouldEncryptHeader(true);   // use this option with password.
//    encoder->setShouldEncryptContent(true);  // use this option with password.
    encoder->setCompressionLevel(9);
    // 3. Add content for archiving.
    //  3.1. Single file path with optional path inside the archive.
    const char *source_dir = env->GetStringUTFChars(source_path, nullptr);
    encoder->add(Path(source_dir));
//    encoder->add(Path("dir/my_file2.txt"), 0, Path("renamed_file2.txt")); // store as "renamed_file2.txt"
    // 4. Open.
    bool opened = encoder->open();
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "compress encoder open result: %s", opened ? "true" : "false");

    // 4. Compress.
    bool compressed = encoder->compress();
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "compress encoder compress result: %s", compressed ? "true" : "false");
    env->ReleaseStringUTFChars(source_path, source_dir);
    return compressed;
}

extern "C"
JNIEXPORT jboolean
Java_com_jackin_flutter_1lzma_LzmaNativeApis_extract(JNIEnv *env, jobject thiz,
                                                     jstring archive_path, jstring target_path) {
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "Native extract");
    // 1. Create a source input stream for reading archive file content.
    //  1.1. Create a source input stream with the path to an archive file.
    const char *source_path = env->GetStringUTFChars(archive_path, nullptr);
    Path archivePath(source_path);
    auto archivePathInStream = makeSharedInStream(archivePath /* std::move(archivePath) */);
    env->ReleaseStringUTFChars(archive_path, source_path);
    // 2. Create decoder with source input stream, type of archive and provide optional delegate.
    auto decoder = makeSharedDecoder(archivePathInStream, plzma_file_type_7z);
    auto * _plzma_progress_delegate = new PLzmaProgressDelegate();
    decoder->setProgressDelegate(_plzma_progress_delegate);

    //  2.1. Optionaly provide the password to open/list/test/extract encrypted archive items.
    // decoder->setPassword("1234");

    try {
        bool opened = decoder->open();
        __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "extract decoder open result: %s", opened ? "true" : "false");
    } catch (Exception &e) {
        __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "extract decoder open failed, exception: %s", e.reason());
        return false;
    }

    // 3. Select archive items for extracting or testing.
    //  3.1. Select all archive items.
    auto archiveItemsCount = decoder->count();
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "extract decoder item count: %d", archiveItemsCount);
    // 4. Extract or test selected archive items. The extract process might be:
    //  4.1. Extract all items to a directory. In this case, you can skip the step #3.
    const char *dest_path = env->GetStringUTFChars(target_path, nullptr);
    bool extracted = decoder->extract(dest_path);
    __android_log_print(ANDROID_LOG_DEBUG, __FUNCTION__, "extract decoder result: %s", extracted ? "true" : "false");
    // release string utf chars
    env->ReleaseStringUTFChars(target_path, dest_path);
    return extracted;
}