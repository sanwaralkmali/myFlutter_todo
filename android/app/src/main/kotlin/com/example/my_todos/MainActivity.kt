package com.example.my_todos

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(LayoutParams.FLAG_SECURE)
    }
}
