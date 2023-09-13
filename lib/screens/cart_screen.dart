import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/empty_bag.dart';
import '../widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              themeProvider.getIsDarkTheme ? Brightness.light : Brightness.dark,
        ),
      ),
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your cart is empty",
        subtitle:
            "Looks like your cart is empty\nadd something and make me happy",
        buttonText: "Shop now",
      ),
    );
  }
}
