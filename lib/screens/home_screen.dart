import 'package:flutter/material.dart';

import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: const AppNameTextWidget(),
      ),
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
