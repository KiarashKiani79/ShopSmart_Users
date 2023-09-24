import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrdersModelAdvanced> _orders = [];
  List<OrdersModelAdvanced> get getOrders => _orders;

  final userstDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<List<OrdersModelAdvanced>> fetchOrders() async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    try {
      await FirebaseFirestore.instance
          .collection("ordersAdvanced")
          .where('userId', isEqualTo: uid)
          .orderBy('orderDate', descending: false)
          .get()
          .then((orderSnapshot) {
        _orders.clear();
        for (var element in orderSnapshot.docs) {
          _orders.insert(
              0,
              OrdersModelAdvanced(
                orderId: element.get('orderId'),
                userId: element.get('userId'),
                productId: element.get('productId'),
                productTitle: element.get('productTitle').toString(),
                userName: element.get('userName'),
                price: element.get('price').toString(),
                imageUrl: element.get('imageUrl'),
                quantity: element.get('quantity').toString(),
                orderDate: element.get('orderDate'),
              ));
        }
      });
      return _orders;
    } catch (e) {
      rethrow;
    }
  }
}
