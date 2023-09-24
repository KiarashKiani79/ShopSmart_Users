import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';
import '../../../providers/order_provider.dart';
import '/models/order_model.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({super.key, required this.ordersModelAdvanced});

  final OrdersModelAdvanced ordersModelAdvanced;

  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25,
              width: size.width * 0.25,
              imageUrl: widget.ordersModelAdvanced.imageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // title
                      Flexible(
                        child: TitlesTextWidget(
                          label: widget.ordersModelAdvanced.productTitle,
                          maxLines: 2,
                          fontSize: 15,
                        ),
                      ),
                      // remove button
                      IconButton(
                          onPressed: () async {
                            await ordersProvider.removeOrderFirebase(
                                orderId: widget.ordersModelAdvanced.orderId);
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                            size: 22,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const TitlesTextWidget(
                        label: 'Price:  ',
                        fontSize: 15,
                      ),
                      Flexible(
                        child: SubtitleTextWidget(
                          label: "${widget.ordersModelAdvanced.price} \$",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleTextWidget(
                        label: "Qty: ${widget.ordersModelAdvanced.quantity}",
                        fontSize: 15,
                      ),
                      FittedBox(
                        child: SubtitleTextWidget(
                          label: DateFormat('MMMM dd, yyyy - HH:mm').format(
                            widget.ordersModelAdvanced.orderDate.toDate(),
                          ),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
