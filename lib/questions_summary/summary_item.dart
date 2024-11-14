import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/questions_summary/question_identifier.dart';

import '../constants.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.itemData});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final bool isCorrectAnswer =
        itemData['correct_answer'] == itemData['user_answer'];

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
              isCorrectAnswer: isCorrectAnswer,
              questionIndex: itemData['question_index'] as int),

          // next to text in a row we want to display a column that contains:
          // - question
          // - chosen answer
          // - correct answer
          // NOTE: first used here (and its Widget), without expended Column
          // can take an infinite amount of space -> a Column without Expanded
          // simple ignored the width and can easily go beyond the size, but
          // when wrapped its actually being wrapped (NOTE: need to experiment
          // with it) i.e. Column with "Expand" only to the size of a "Row",
          // so its all about restriction for expansion here
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // question text
                Text(
                  itemData['question'] as String,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(itemData['user_answer'] as String,
                    style: const TextStyle(
                      color: Color.fromARGB(
                        255,
                        202,
                        171,
                        252,
                      ),
                    )),
                Text(
                  itemData['correct_answer'] as String,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 181, 254, 246)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
