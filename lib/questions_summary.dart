import 'package:flutter/material.dart';
import 'package:quiz_app/questions_summary/summary_item.dart';

import 'questions_summary/question_identifier.dart';
import 'constants.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  Color answerColour(bool correctAnswer) {
    return correctAnswer ? Colors.blue : Colors.purpleAccent;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,

      // only has direct child (column in this case) we make it scrollable
      // NOTE: a key widget that we should be aware of
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            // new widget that we never used so far
            return SummaryItem(itemData: data);
          }).toList(), // chain list to map really here
        ),
      ),
    );
  }
}
