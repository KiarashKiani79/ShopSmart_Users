import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/cart_model.dart';
import '../../providers/products_provider.dart';
import '../../widgets/products/heart_btn.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';
import 'quantity_btm_sheet.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(cartModel.productId);
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Card(
            elevation: 4,
            child: FittedBox(
              child: IntrinsicWidth(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FancyShimmerImage(
                          imageUrl: getCurrProduct.productImage,
                          height: size.height * 0.2,
                          width: size.height * 0.2,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IntrinsicWidth(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // title
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: TitlesTextWidget(
                                    label: getCurrProduct.productTitle,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: [
                                    // remove button
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.remove_circle_outline_rounded,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    // heart button
                                    const HeartButtonWidget(),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // Price
                                SubtitleTextWidget(
                                  label: "${getCurrProduct.productPrice}\$",
                                  color: Colors.blue,
                                ),
                                const Spacer(),
                                // Quantity
                                OutlinedButton.icon(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return QuantityBottomSheetWidget(
                                          cartModel: cartModel,
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(IconlyLight.arrowDown2),
                                  label: Text("Qty: ${cartModel.quantity}"),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
