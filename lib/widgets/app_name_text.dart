import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import '/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 10),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: const TitlesTextWidget(
        label: "Shop Smart",
      ),
    );
  }
}
