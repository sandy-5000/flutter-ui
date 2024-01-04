import 'package:flutter/material.dart';
import 'package:flutter_ui/pages/fitness.dart';
import 'package:flutter_ui/pages/prompt_today.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  Map<String, Widget> pages = {
    'prompt_today': const PromptTodayPage(),
    'fitness': const FitnessPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: pages['fitness'],
    );
  }
}
