import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';

import '../../screens/inner_screen/product_details.dart';
import '../subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewedProd(productId: productsModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetailsScreen.routName,
            arguments: productsModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                // image
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    // title
                    Text(
                      productsModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          // heart button
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          // cart button
                          IconButton(
                            onPressed: () {
                              if (cartProvider.isProdinCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: productsModel.productId);
                            },
                            icon: Icon(
                              cartProvider.isProdinCart(
                                      productId: productsModel.productId)
                                  ? Ionicons.checkmark_done
                                  : Icons.add_shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // price
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: "${productsModel.productPrice}\$",
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
