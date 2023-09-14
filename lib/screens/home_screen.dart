import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: const AppNameTextWidget(),
        systemOverlayStyle: statusBarTheme(themeProvider),
      ),
      body: const Center(
        child: TitlesTextWidget(label: 'HomeScreen'),
      ),
    );
  }
}
