import 'package:flutter/material.dart';

import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SubtitleTextWidget(
              label: "Hello world!!!!!",
            ),
            TitlesTextWidget(
              label: "Hello this is a title" * 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Hello world")),
          ],
        ),
      ),
    );
  }
}
