import 'package:flutter/material.dart';

import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
        child: TitlesTextWidget(label: "CartScreen"),
      ),
    );
  }
}
