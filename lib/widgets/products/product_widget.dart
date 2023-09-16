import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';
import 'heart_btn.dart';

class ProductWidget extends StatefulWidget {
  final String productId;

  const ProductWidget({
    required this.productId,
    super.key,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(widget.productId);
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routName,
                  arguments: getCurrProduct.productId,
                );
              },
              child: Column(
                children: [
                  // image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        // title
                        Flexible(
                          flex: 5,
                          child: TitlesTextWidget(
                            label: getCurrProduct.productTitle,
                            fontSize: 18,
                            maxLines: 2,
                          ),
                        ),
                        // heart button
                        const Flexible(
                          flex: 2,
                          child: HeartButtonWidget(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // price
                        Flexible(
                          child: SubtitleTextWidget(
                            label: "${getCurrProduct.productPrice}\$",
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        // add cart button
                        Flexible(
                          child: IconButton(
                            highlightColor: Colors.blue,
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.blue.withOpacity(.3),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.add_shopping_cart_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
          );
  }
}
