import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;
  final void Function() onRestart;

  // Object is quite a flexible type that will allow us to group different types
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,

          // for simplicity we made 0 index is a correct answer, BUT to avoid
          // direct guessing we shuffled the questions when we rendered actual
          // screen widget
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;

    // that generates a list where if element is equals then it stays in the
    // list, otherwise its dropped (then we count length of this list) to get
    // number of correct answers
    // can be used as lambda instead of anonymous function
    final numCorrectQuestions = summaryData.where((data) => data['correct_answer'] == data['user_answer']).length;

    // TODO: why sized box and not container directly
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
            // vertical alignment for column (in certain situations it might be very
            // useful i.e. spaceAround for example -> distribute the size between
            // elements
            // NOTE: if not set here, all container will be pushed on top
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(summaryData: summaryData),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white
                  ),
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Restart Quiz!')
              ),
              // OutlinedButton.icon(
              //   onPressed: restartQuiz,
              //
              //   // an easier way to build the style taking into an account existing
              //   // it just makes it easier to apply styles
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: const Color.fromARGB(255, 210, 183, 244),
              //     side: BorderSide.none,
              //   ),
              //   icon: const Icon(Icons.restart_alt),
              //
              //   // if non icon constructor then it could be child: Text(...)
              //   label: Text("Restart Quiz!",
              //       style: GoogleFonts.lato(
              //           fontSize: 16
              //       )),
              // ),
            ]),
      ),
    );
  }
}
