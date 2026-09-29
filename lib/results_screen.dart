import 'package:flutter/material.dart';

import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.choosenAnswer,
    required this.onRestartQuiz,
  });

  final List<String> choosenAnswer;
  final void Function() onRestartQuiz;

  /* List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswer[i],
      });
    }

    return summary;
  } */

  // ! quando si ha un metodo che modifica solo i dati memorizzati come in questo caso senza fare altro
  // # si può definirlo come di seguito ed avere accesso direttamente alla variabile senza richiamare il metodo
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswer[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    //final summaryData = getSummaryData();
    // ! si ha accesso alla variabile summaryData senza dover richiamare il metodo
    final numCorrectAnswer = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;
    final numTotalQuestions = questions.length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answerd $numCorrectAnswer out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: Color.fromARGB(255, 208, 168, 250),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(
              summaryData: summaryData,
            ),
            const SizedBox(height: 30),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              onPressed: onRestartQuiz,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              label: Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
