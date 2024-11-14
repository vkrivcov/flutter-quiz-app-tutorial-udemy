import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

// Quiz class acts as a controller (screen that lifts state) for everything else
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// private class so technically it could be used only in this class
class _QuizState extends State<Quiz> {
  static const List<Color> gradientColors = [
    Color.fromARGB(255, 53, 9, 101),
    Color.fromARGB(255, 107, 15, 168)
  ];
  static const beginAlignmentPosition = Alignment.topLeft;
  static const endAlignmentPosition = Alignment.bottomRight;

  // advantage of using different identifiers for different screens using
  // string -> we can initialise and then we can use a specific widget
  // that can simply switch screens based on string values
  var activeScreen = 'start-screen';

  // since this is the class that has access to all of the screens etc.
  // (and also acts as the main screen for lifting the state e.g.
  // start-screen <- quiz -> questions-screen etc, we need to store the
  // following here:
  // can be final as we will not reassign it to another value
  // - number of questions answered
  // - actual answers
  final List<String> selectedAnswers = [];

  // NOTE: this is one (and perhaps a bit lengthily way of initialise first
  // screen, but there is a shorter way (see above)
  // var would be TOO restrictive and we if we would assign the value to var
  // then it would not work -> StartScreen (as default value) is storing its
  // specific state (and some internal type) and we are not allowed really to
  // re-assign it, instead we can use genetic type Widget that would allow us
  // to switch them without any problems as all of them extend widget super
  // class (its more of a general type in this context)
  // Widget? activeScreen;

  // you probably want to add this method to your widgets (not sure if it will
  // apply to sate less widgets though)
  // @override
  // void initState() {
  //   super.initState();
  //   activeScreen = StartScreen(switchScreen);
  // }

  // looks like a default for this one is whatever you specify in build method
  // and setState is just a separate thing?
  switchScreen() {
    setState(() {
      selectedAnswers.clear();
      activeScreen = 'questions-screen';
      // NOTE: that was a part of the option above
      //activeScreen = const QuestionsScreen();
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      // when we match all of the questions we start the results screen
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // another way of using ternary expression
    // var screenWidget = activeScreen == 'start-screen'
    //     ? StartScreen(switchScreen)
    //     : const QuestionsScreen();

    // another way
    Widget screenWidget = StartScreen(switchScreen);

    // this code is executed conditionally
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectedAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(chosenAnswers: selectedAnswers, onRestart: switchScreen);
    }

    return MaterialApp(
      home: Scaffold(
        // we want to add specific screen to ALL pages, not a specific one
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: gradientColors,
                begin: beginAlignmentPosition,
                end: endAlignmentPosition),
          ),
          // instead use ternary expression -> this is perfectly valid
          // child: activeScreen == 'start-screen'
          //     ? StartScreen(switchScreen)
          //     : const QuestionsScreen(),

          // but there is even a more better way of doing it, but it might not
          // be that flexible + harder to read
          child: screenWidget,

          // NOTE: part of option 1
          //child: activeScreen,
        ),
      ),
    ); // MaterialApp
  }
}