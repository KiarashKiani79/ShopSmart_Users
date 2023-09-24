import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import '../services/my_app_functions.dart';
import '/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartitems {
    return _cartItems;
  }

// ****************************** Firebase ******************************

  final userstDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

// Add to cart - Firebase
  Future<void> addToCartFirebase({
    required String productId,
    required int qty,
    required BuildContext context,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please login first",
        fct: () => Navigator.of(context).pushNamed(LoginScreen.routName),
        buttonText: 'Login',
      );
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      await userstDb.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Added to cart successfully");
    } on FirebaseException catch (error) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.message.toString(),
        fct: () {},
      );
    } catch (e) {
      rethrow;
    }
  }

// Fetch cart - Firebase
  Future<void> fetchCart() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      final userDoc = await userstDb.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        return;
      }
      final len = userDoc.get("userCart").length;
      for (int index = 0; index < len; index++) {
        _cartItems.putIfAbsent(
          userDoc.get("userCart")[index]['productId'],
          () => CartModel(
              cartId: userDoc.get("userCart")[index]['cartId'],
              productId: userDoc.get("userCart")[index]['productId'],
              quantity: userDoc.get("userCart")[index]['quantity']),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

// Remove One - Firebase
  Future<void> removeItemFromFirestore({
    required String cartId,
    required String productId,
    required int qty,
  }) async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    try {
      await userstDb.doc(uid).update({
        'userCart': FieldValue.arrayRemove([
          {'cartId': cartId, 'quantity': qty, 'productId': productId},
        ]),
      });
      _cartItems.remove(productId);
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Item removed successfully");
    } catch (e) {
      rethrow;
    }
  }

// Remove All - Firebase
  Future<void> removeAllItemsFromFirestore(
      {String msg = "Cart cleared successfully"}) async {
    final User? user = _auth.currentUser;

    final uid = user!.uid;

    try {
      await userstDb.doc(uid).update({
        'userCart': [],
      });
      _cartItems.clear();
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: msg);
    } catch (e) {
      rethrow;
    }
  }

// ****************************** Localy ******************************

// Add to cart - Localy
  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
          cartId: const Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

// Update Quantity - Localy
  void updateQty({required String productId, required int qty}) {
    _cartItems.update(
      productId,
      (cartItem) => CartModel(
        cartId: cartItem.cartId,
        productId: productId,
        quantity: qty,
      ),
    );
    notifyListeners();
  }

// Remove All - Localy
  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }

// Remove One - Localy
  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

// Get Total - Localy
  double getTotal({required ProductsProvider productsProvider}) {
    double total = 0.0;

    _cartItems.forEach((key, value) {
      final getCurrProduct = productsProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

// Get Quantity - Localy
  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

// Check if product is in cart - Localy
  bool isProdinCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }
}
