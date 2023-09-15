import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../consts/theme_data.dart';
import '../../providers/theme_provider.dart';
import '../../services/assets_manager.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';
import 'bottom_checkout.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  "Looks like your cart is empty add something and make me happy",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomSheetWidget(),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AssetsManager.shoppingCart,
                ),
              ),
              title: const TitlesTextWidget(label: "Cart (6)"),
              actions: [
                PopupMenuButton(
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'clear',
                      child: Row(
                        children: [
                          Icon(
                            IconlyBold.delete,
                            color: Colors.red,
                          ),
                          SizedBox(width: 4),
                          Text('Delete All'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'clear') {
                      // Call the clear method here
                    }
                  },
                ),
              ],
              systemOverlayStyle: statusBarTheme(themeProvider),
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CartWidget();
                }),
          );
  }
}
