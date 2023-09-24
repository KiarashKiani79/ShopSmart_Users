import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import '../../../../widgets/empty_bag.dart';
import '../../../consts/theme_data.dart';
import '../../../models/order_model.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/assets_manager.dart';
import '../../../services/my_app_functions.dart';
import '../../../widgets/title_text.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final ordersProvider = Provider.of<OrderProvider>(context, listen: true);
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              )
            : null,
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
        systemOverlayStyle: statusBarTheme(themeProvider),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(
                      IconlyBold.delete,
                      color: Colors.red,
                    ),
                    SizedBox(width: 4),
                    Text('Delete All'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'clear') {
                MyAppFunctions.showErrorOrWarningDialog(
                  isError: false,
                  context: context,
                  subtitle: "Clear Cart?",
                  buttonText: "Delete All",
                  fct: () async {
                    ordersProvider.removeAllOrdersFromFirestore();
                  },
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop now",
              isItOrderBag: true,
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidgetFree(
                  ordersModelAdvanced: ordersProvider.getOrders[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                indent: deviceSize.width * 0.125,
                endIndent: deviceSize.width * 0.125,
                thickness: 2,
              );
            },
          );
        },
      ),
    );
  }
}
