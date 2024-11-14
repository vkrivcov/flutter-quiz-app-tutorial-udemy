import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectedAnswer});

  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  // star with the first question
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    // special widget property that related to a widget and its properties
    widget.onSelectedAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      // special value
      width: double.infinity,

      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          // vertical alignment for column (in certain situations it might be very
          // useful i.e. spaceAround for example -> distribute the size between
          // elements
          mainAxisAlignment: MainAxisAlignment.center,

          // horizontal axis -> stretch will spread as much as possible
          // in that case we need padding or margin -> to do that we wrapped it
          // in another element that is container
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Text(
              // we want to center text visually within the Column parent
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 201, 152, 251),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            // use loop to generate multiple Widgets
            // NOTE: ...is a spreading operator that will generate whatever number
            // of elements that is needed!
            ...currentQuestion.getShuffledAnswers().map((answerText) {
              return AnswerButton(
                  answerText: answerText,
                  onTap: () {
                    answerQuestion(answerText);
                  });
            })

            // initial example, replaced with the above
            // AnswerButton(answerText: currentQuestion.answers[0], onTap: () {}),
            // AnswerButton(answerText: currentQuestion.answers[1], onTap: () {}),
            // AnswerButton(answerText: currentQuestion.answers[2], onTap: () {}),
            // AnswerButton(answerText: currentQuestion.answers[3], onTap: () {})
          ],
        ),
      ),
    );
  }
}