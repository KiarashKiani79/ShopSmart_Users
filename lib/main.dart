import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/auth/register.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
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
          // home: const RootScreen(),
          home: const LoginScreen(),
          routes: {
            ProductDetailsScreen.routName: (context) =>
                const ProductDetailsScreen(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            // LoginScreen.routeName: (context) => const LoginScreen(),
          },
        );
      }),
    );
  }
}
