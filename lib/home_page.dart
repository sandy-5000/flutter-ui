import 'package:flutter/material.dart';
import 'package:flutter_ui/pages/prompt_today.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PromptTodayPage(),
    );
  }
}
