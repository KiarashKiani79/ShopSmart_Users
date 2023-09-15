import 'package:flutter/material.dart';

import '../widgets/subtitle_text.dart';
import 'assets_manager.dart';

class MyAppFunctions {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    String buttonText = "OK",
    bool isError = true,
    required Function fct,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image
                Image.asset(
                  isError ? AssetsManager.error : AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                // subtitle
                SubtitleTextWidget(
                  label: subtitle,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            // buttons
            actions: [
              Visibility(
                visible: !isError,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const SubtitleTextWidget(
                    label: "Cancel",
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SubtitleTextWidget(
                  label: buttonText,
                  color: Colors.red,
                ),
              ),
            ],
          );
        });
  }
}
