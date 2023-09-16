import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/theme_data.dart';
import '../../providers/products_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/products/heart_btn.dart';
import '/widgets/title_text.dart';

import '../../consts/app_constants.dart';
import '../../widgets/app_name_text.dart';
// import '../../widgets/products/heart_btn.dart';
import '../../widgets/subtitle_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productsProvider.findByProdId(productId);
    return Scaffold(
      // appBar
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const AppNameTextWidget(),
        systemOverlayStyle: statusBarTheme(themeProvider),
      ),
      // body
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.38,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Flexible(
                              child: Text(
                                getCurrProduct.productTitle,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // price
                            SubtitleTextWidget(
                              label: "${getCurrProduct.productPrice}\$",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // heart button
                              HeartButtonWidget(
                                bkgColor: Colors.pink.withOpacity(0.30),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              // add to cart button
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // about this item
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(label: "About this item"),
                            SubtitleTextWidget(
                                label: "In ${getCurrProduct.productCategory}"),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // description
                        SubtitleTextWidget(
                            label: getCurrProduct.productDescription),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
