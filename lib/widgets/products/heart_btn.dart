import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';
import '../../services/my_app_functions.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.bkgColor = Colors.transparent,
    this.size = 24,
    required this.productId,
  });
  final double size;
  final Color bkgColor;
  final String productId;
  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistsProvider = Provider.of<WishlistProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: widget.bkgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(elevation: 10),
        onPressed: () async {
          try {
            if (wishlistsProvider.getWishlists.containsKey(widget.productId)) {
              await wishlistsProvider.removeWishlistItemFromFirestore(
                wishlistId: wishlistsProvider
                    .getWishlists[widget.productId]!.wishlistId,
                productId: widget.productId,
              );
            } else {
              await wishlistsProvider.addToWishlistFirebase(
                productId: widget.productId,
                context: context,
              );
            }
            await wishlistsProvider.fetchWishlist();
          } catch (e) {
            await MyAppFunctions.showErrorOrWarningDialog(
              context: context,
              subtitle: e.toString(),
              fct: () {},
            );
          }
        },
        icon: Icon(
          wishlistsProvider.isProdinWishlist(
            productId: widget.productId,
          )
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color: wishlistsProvider.isProdinWishlist(
            productId: widget.productId,
          )
              ? Colors.red
              : Colors.grey,
        ),
      ),
    );
  }
}
