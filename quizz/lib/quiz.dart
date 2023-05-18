import 'package:flutter/material.dart';
import 'package:quizz/data/questions.dart';
import 'package:quizz/questions_screen.dart';
import 'package:quizz/results_screen.dart';
import 'package:quizz/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(selectAnswer);
    });
  }

  void restartQuiz() {
    setState(() {
      activeScreen = StartScreen(switchScreen);
    });
  }

  void selectAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          restartQuiz: restartQuiz,
        );
      });
      selectedAnswers = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 94, 43, 181),
                Color.fromARGB(255, 94, 7, 141),
              ],
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
