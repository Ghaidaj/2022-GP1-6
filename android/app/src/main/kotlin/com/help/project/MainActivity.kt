package com.help.project
import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.telephony.SmsManager
import android.util.Config.DEBUG
import android.util.Log
import android.util.Log.DEBUG
import androidx.annotation.NonNull
import io.flutter.Log.DEBUG
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity
import android.content.Intent




class MainActivity : FlutterActivity() {
    // private MethodChannel.Result callResult;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(
                            Manifest.permission.SEND_SMS)
                    != PackageManager.PERMISSION_GRANTED) {

                // Should we show an explanation?
                if (shouldShowRequestPermissionRationale(
                                Manifest.permission.SEND_SMS)) {
                } else {
                    requestPermissions(arrayOf(Manifest.permission.SEND_SMS),
                            0)
                }
            }
        }
        MethodChannel(getBinaryMessenger(), CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "send") {

                val phoneNos = call.argument<String>("phoneNumbers")
                val msg = call.argument<String>("message")

                sendSMS(phoneNos, msg, result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBinaryMessenger(): BinaryMessenger {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }

    private fun sendSMS(phoneNos: String?, msg: String?, result: MethodChannel.Result) {
        try {

            if(phoneNos != null)
            {
                val smsManager = SmsManager.getDefault();

                val smsParts: ArrayList<String> = smsManager.divideMessage(msg)
                 for (phoneNo in phoneNos.split(",")) {
                    smsManager.sendMultipartTextMessage(phoneNo, null, smsParts, null, null);
                }
                result.success("SMS Sent")
            }

        } catch (ex: Exception) {
            ex.printStackTrace()
            result.error("Err", "Sms Not Sent", "")
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int,
                                            permissions: Array<String>, grantResults: IntArray) {
        when (requestCode) {
            0 -> {

                if (grantResults.isNotEmpty()
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                } else {

                }
                return
            }
        }
    }

    companion object {
        private const val CHANNEL = "sendSms"
    }
}

