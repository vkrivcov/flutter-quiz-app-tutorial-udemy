class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  // NOTE: we don't want to use shuffle on the list directly as it will change
  // the order of elements, instead we want to return a copy of existing answers
  List<String> getShuffledAnswers() {
    // List.of will return a brand new list so essentially a copy and not a ref
    final shuffledList = List.of(answers);
    shuffledList.shuffle();  // we are not changing list, just shuffling
    return List.of(shuffledList);
  }
}