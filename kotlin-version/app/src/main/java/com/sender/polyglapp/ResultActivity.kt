package com.sender.polyglapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import com.sender.polyglapp.databinding.ActivityResultBinding

class ResultActivity : AppCompatActivity() {
    private lateinit var binding: ActivityResultBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityResultBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val points: String = intent.getStringExtra("points")!!

        val result = binding.result
        result.text = String.format(getResources().getString(R.string.result), points)
    }

    fun restart(view:View) {
        val intent = Intent(this, MainActivity::class.java)
        startActivity(intent)
    }
}