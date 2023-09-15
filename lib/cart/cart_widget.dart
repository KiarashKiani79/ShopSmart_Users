import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../widgets/products/heart_btn.dart';
import '/cart/quantity_btm_sheet.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
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
                    imageUrl:
                        'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
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
                              label: "Title" * 15,
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
                          const SubtitleTextWidget(
                            label: "16.00\$",
                            color: Colors.blue,
                          ),
                          const Spacer(),
                          // Quantity
                          OutlinedButton.icon(
                            onPressed: () async {
                              await showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return const QuantityBottomSheetWidget();
                                },
                              );
                            },
                            icon: const Icon(IconlyLight.arrowDown2),
                            label: const Text("Qty: 6"),
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
