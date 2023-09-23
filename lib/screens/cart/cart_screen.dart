import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../consts/theme_data.dart';
import '../../providers/cart_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/assets_manager.dart';
import '../../services/my_app_functions.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';
import 'bottom_checkout.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartitems.isEmpty
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
              title: TitlesTextWidget(
                  label: "Cart (${cartProvider.getCartitems.length})"),
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
                      MyAppFunctions.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Clear Cart?",
                        buttonText: "Delete All",
                        fct: () async {
                          cartProvider.removeAllItemsFromFirestore();
                        },
                      );
                    }
                  },
                ),
              ],
              systemOverlayStyle: statusBarTheme(themeProvider),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.getCartitems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartitems.values
                                .toList()[index],
                            child: const CartWidget());
                      }),
                ),
                const SizedBox(height: kBottomNavigationBarHeight + 30),
              ],
            ),
          );
  }
}
