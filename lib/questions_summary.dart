import 'package:flutter/material.dart';
import 'package:quiz_app/questions_summary/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  // NOTE: getting the right answer can be wrapped in a helper function (not
  // used in this class)
  // Color answerColour(bool correctAnswer) {
  //   return correctAnswer ? Colors.blue : Colors.purpleAccent;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // we can get percentage of the screen (not sure if it will overflow)
      // height: MediaQuery.of(context).size.height * 0.6,
      height: 400,

      // only has direct child (column in this case) we make it scrollable
      // NOTE: a key widget that we should be aware of
      child: SingleChildScrollView(
        child: Column(
          // map will iterate through every component as in getShuffledAnswers
          // Question class
          children: summaryData.map((data) {
            // new widget that we never used so far
            return SummaryItem(itemData: data);
            // NOTE: important point below on how to return list of widgets
          }).toList(),
        ),
      ),
    );
  }
}
