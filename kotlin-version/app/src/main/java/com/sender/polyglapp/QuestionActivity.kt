package com.sender.polyglapp

import android.content.Intent
import android.graphics.drawable.ColorDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.RadioButton
import com.sender.polyglapp.databinding.ActivityQuestionBinding

class QuestionActivity : AppCompatActivity() {
    private lateinit var binding: ActivityQuestionBinding
    var counter = 0
    var points = 0
    var actualAnswer = ""
    val words = arrayListOf<String>("Ragazzo", "Bread", "Kофе", "カメ", "Vin", "Baum", "Playa", "Valp", "Računalo", "Πέτρα")
    val answers = arrayListOf<String>("Menino", "Pão", "Café", "Tartaruga", "Vinho", "Árvore", "Praia", "Cachorro", "Computador", "Pedra")
    val answersAux = arrayListOf<String>("Menino", "Pão", "Café", "Tartaruga", "Vinho", "Árvore", "Praia", "Cachorro", "Computador", "Pedra")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityQuestionBinding.inflate(layoutInflater)
        setContentView(binding.root)

        var username: String = intent.getStringExtra("username")!!
        username = username.capitalize()
        val question = binding.question
        question.text = String.format(getResources().getString(R.string.question), username)

        raffleWords()
    }

    fun raffleWords() {
        val submitButton = binding.submitAnswer
        val word = binding.word
        val optionFirst = binding.radioFirst
        val optionSecond = binding.radioSecond
        val optionThird = binding.radioThird

        if (counter > 0) {
            submitButton.isEnabled = false
            optionFirst.setBackground(ColorDrawable(getColor(R.color.purple_200)))
            optionSecond.setBackground(ColorDrawable(getColor(R.color.purple_200)))
            optionThird.setBackground(ColorDrawable(getColor(R.color.purple_200)))
        }

        var randomNumberWord = (0..words.size-1).random()
        val selectedQuestion = words[randomNumberWord]
        word.text = selectedQuestion

        val rightAnswer = answersAux[randomNumberWord]
        var rightAnswerPlace = (0..2).random()
        var alreadySelected = mutableListOf<String>()
        alreadySelected.add(answersAux[randomNumberWord])

        actualAnswer = rightAnswer
        words.removeAt(randomNumberWord)
        answersAux.removeAt(randomNumberWord)

        when (rightAnswerPlace) {
            0 -> optionFirst.text = rightAnswer
            1 -> optionSecond.text = rightAnswer
            else -> optionThird.text = rightAnswer
        }

        var i = 0
        while (i < 2) {
            var randomNumberOption = (0..answers.size-1).random()

            if (answers[randomNumberOption] !in alreadySelected) {
                alreadySelected.add(answers[randomNumberOption])

                val selectedOption = answers[randomNumberOption]

                if (rightAnswerPlace == 0) {
                    if (i == 0) {
                        optionSecond.text = selectedOption
                    } else if (i == 1) {
                        optionThird.text = selectedOption
                    }
                } else if (rightAnswerPlace == 1) {
                    if (i == 0) {
                        optionFirst.text = selectedOption
                    } else if (i == 1) {
                        optionThird.text = selectedOption
                    }
                } else if (rightAnswerPlace == 2) {
                    if (i == 0) {
                        optionFirst.text = selectedOption
                    } else if (i == 1) {
                        optionSecond.text = selectedOption
                    }
                }

                i++
            }
        }
    }

    fun onRadioButtonClicked(view: View) {
        if (view is RadioButton) {
            // Is the button now checked?
            val checked = view.isChecked

            // Check which radio button was clicked
            when (view.getId()) {
                R.id.radioFirst ->
                    if (checked) {
                        val submitButton = binding.submitAnswer
                        val optionFirst = binding.radioFirst
                        val optionSecond = binding.radioSecond
                        val optionThird = binding.radioThird

                        submitButton.isEnabled = true

                        optionFirst.setBackground(ColorDrawable(getColor(R.color.purple_500)))
                        optionSecond.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                        optionThird.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                    }
                R.id.radioSecond ->
                    if (checked) {
                        val submitButton = binding.submitAnswer
                        val optionFirst = binding.radioFirst
                        val optionSecond = binding.radioSecond
                        val optionThird = binding.radioThird

                        submitButton.isEnabled = true

                        optionFirst.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                        optionSecond.setBackground(ColorDrawable(getColor(R.color.purple_500)))
                        optionThird.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                    }
                R.id.radioThird ->
                    if (checked) {
                        val submitButton = binding.submitAnswer
                        val optionFirst = binding.radioFirst
                        val optionSecond = binding.radioSecond
                        val optionThird = binding.radioThird

                        submitButton.isEnabled = true

                        optionFirst.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                        optionSecond.setBackground(ColorDrawable(getColor(R.color.purple_200)))
                        optionThird.setBackground(ColorDrawable(getColor(R.color.purple_500)))
                    }
            }
        }
    }

    fun submitAnswer(view: View) {
        counter++

        val optionFirst = binding.radioFirst
        val optionSecond = binding.radioSecond
        val optionThird = binding.radioThird
        var submitted: String = ""

        if (optionFirst.isChecked == true) {
            submitted = optionFirst.text.toString()
        } else if (optionSecond.isChecked == true) {
            submitted = optionSecond.text.toString()
        } else if (optionThird.isChecked == true) {
            submitted = optionThird.text.toString()
        }

        if (actualAnswer == submitted) {
            points++
        }

        if (counter == 10) {
            val intent = Intent(this, ResultActivity::class.java)
            intent.putExtra("points", points.toString())
            startActivity(intent)
        } else {
            raffleWords()
        }
    }
}