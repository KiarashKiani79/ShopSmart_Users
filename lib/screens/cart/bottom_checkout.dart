import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key, required this.function});
  final Function function;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitlesTextWidget(
                          label:
                              "Total (${cartProvider.getCartitems.length} products/${cartProvider.getQty()} items)"),
                    ),
                    SubtitleTextWidget(
                      label:
                          "${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)}\$",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await function();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: themeProvider.getIsDarkTheme
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: const Text("Checkout")),
            ],
          ),
        ),
      ),
    );
  }
}
