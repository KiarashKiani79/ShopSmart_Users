import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../screens/inner_screen/product_details.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';
import 'heart_btn.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, ProductDetailsScreen.routName);
        },
        child: Column(
          children: [
            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
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
                      label: "Title " * 10,
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
                  const Flexible(
                    child: SubtitleTextWidget(
                      label: "1550.00\$",
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