package com.sender.polyglapp

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.sender.polyglapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    var username: String = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }

    fun saveName(view:View) {
        username = binding.edtUsername.text.toString()
        val result = isLetters(username)
        if (username == "") {
            Toast.makeText(this, "É necessário inserir um nome.", Toast.LENGTH_SHORT).show()
        } else if (result == false) {
            Toast.makeText(this, "É necessário inserir um nome válido.", Toast.LENGTH_SHORT).show()
        } else {
            val intent = Intent(this, QuestionActivity::class.java)
            intent.putExtra("username", username);
            startActivity(intent)
        }
    }

    fun isLetters(string: String): Boolean {
        return string.all { it.isLetter() }
    }
}