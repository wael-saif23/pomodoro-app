import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(const Pomodoro());

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

