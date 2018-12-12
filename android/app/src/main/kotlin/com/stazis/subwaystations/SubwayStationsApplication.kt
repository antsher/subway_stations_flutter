package com.stazis.subwaystations

import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class SubwayStationsApplication : FlutterApplication() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.LOLLIPOP) {
            MultiDex.install(this)
        }
    }
}