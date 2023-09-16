import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/inner_screen/orders/orders_screen.dart';
import '/root_screen.dart';
import '/screens/auth/login.dart';
import '/screens/auth/register.dart';
import '/screens/inner_screen/viewed_recently.dart';
import '/screens/inner_screen/wishlist.dart';
import './providers/theme_provider.dart';

import 'consts/theme_data.dart';
import 'screens/inner_screen/product_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ShopSmart',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const RootScreen(),
          routes: {
            RootScreen.routName: (context) => const RootScreen(),
            ProductDetailsScreen.routName: (context) =>
                const ProductDetailsScreen(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            LoginScreen.routName: (context) => const LoginScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
          },
        );
      }),
    );
  }
}
