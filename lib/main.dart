import 'package:eloquent_quiz/screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

main(List<String> args) {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}
