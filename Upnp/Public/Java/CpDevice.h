/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class openhome_net_controlpoint_CpDevice */

#ifndef _Included_openhome_net_controlpoint_CpDevice
#define _Included_openhome_net_controlpoint_CpDevice
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     openhome_net_controlpoint_CpDevice
 * Method:    CpDeviceCUdn
 * Signature: (J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_openhome_net_controlpoint_CpDevice_CpDeviceCUdn
  (JNIEnv *, jobject, jlong);

/*
 * Class:     openhome_net_controlpoint_CpDevice
 * Method:    CpDeviceCAddRef
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_openhome_net_controlpoint_CpDevice_CpDeviceCAddRef
  (JNIEnv *, jobject, jlong);

/*
 * Class:     openhome_net_controlpoint_CpDevice
 * Method:    CpDeviceCRemoveRef
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_openhome_net_controlpoint_CpDevice_CpDeviceCRemoveRef
  (JNIEnv *, jobject, jlong);

/*
 * Class:     openhome_net_controlpoint_CpDevice
 * Method:    CpDeviceCGetAttribute
 * Signature: (JLjava/lang/String;[Ljava/lang/String;)I
 */
JNIEXPORT jint JNICALL Java_openhome_net_controlpoint_CpDevice_CpDeviceCGetAttribute
  (JNIEnv *, jobject, jlong, jstring, jobjectArray);

#ifdef __cplusplus
}
#endif
#endif