package com.aric.apex_value_device_checking

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    // nothing else needed
}


// Use Below If YOu Are Using Platform Channel

//package com.aric.apex_value_device_checking
//
//import android.nfc.NfcAdapter
//import android.os.Bundle
//import io.flutter.embedding.android.FlutterFragmentActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.embedding.engine.FlutterEngineCache
//import io.flutter.FlutterInjector
//import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode
//
//class MainActivity : FlutterFragmentActivity() {
//    private val CHANNEL = "nfc_hardware_check"
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        // Create FlutterEngine if not already cached
//        val flutterEngine = FlutterInjector.instance().flutterLoader().let {
//            val engine = FlutterEngine(this)
//            it.startInitialization(this)
//            it.ensureInitializationComplete(this, null)
//            engine
//        }
//
//        // Set up MethodChannel
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//                call, result ->
//            if (call.method == "hasNfcHardware") {
//                val nfcAdapter: NfcAdapter? = NfcAdapter.getDefaultAdapter(this)
//                result.success(nfcAdapter != null)
//            } else {
//                result.notImplemented()
//            }
//        }
//
//        // Cache the engine (optional, for reuse)
//        FlutterEngineCache.getInstance().put("main_engine", flutterEngine)
//    }
//}
