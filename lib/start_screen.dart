import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    // get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    // set the desired width and height as a proportion of the screen size
    final imageWidth = screenWidth * 0.7;

    return Center(
      child: Column(
        // take min vertical axis size
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/quiz-logo.png",
              width: imageWidth,

              // first value is an opacity and set overlay color to write in this case
              // NOTE: can also wrap it with Opacity but its VERY intensive
              color: const Color.fromARGB(150, 255, 255, 255)),

          // just one was of adding a bit of space
          const SizedBox(
            height: 80,
          ),
          Text(
            "Learn Flutter the fun way!",
            style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 210, 183, 244), fontSize: 24),
          ),
          const SizedBox(
            height: 30,
          ),
          // () {} anonymous function -> does not do anything
          OutlinedButton.icon(
            // one way of triggering it
            // onPressed: () {
            //   starQuiz();
            // },

            // another way
            onPressed: startQuiz,

            // an easier way to build the style taking into an account existing
            // it just makes it easier to apply styles
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 210, 183, 244),
              side: BorderSide.none,
            ),
            icon: const Icon(Icons.arrow_right_alt),

            // if non icon constructor then it could be child: Text(...)
            label: Text("Start Quiz!", style: GoogleFonts.lato(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
