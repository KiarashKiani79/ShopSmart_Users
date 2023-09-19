import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import '../consts/theme_data.dart';
import '../services/my_app_functions.dart';
import '/services/assets_manager.dart';
import '/widgets/subtitle_text.dart';

import '../providers/theme_provider.dart';
import '../widgets/title_text.dart';
import 'auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: const AppNameTextWidget(),
        systemOverlayStyle: statusBarTheme(themeProvider),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitlesTextWidget(
                  label: "Please login to have unlimited access",
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(label: "Kiarash Kiani"),
                        SizedBox(
                          height: 6,
                        ),
                        SubtitleTextWidget(label: "kiarash.kiani7997@gmail.com")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TitlesTextWidget(
                      label: "General",
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        CustomListTile(
                          text: "All Order",
                          imagePath: AssetsManager.orderSvg,
                          function: () => Navigator.pushNamed(
                              context, OrdersScreen.routeName),
                        ),
                        CustomListTile(
                          text: "Wishlist",
                          imagePath: AssetsManager.wishlistSvg,
                          function: () {
                            Navigator.pushNamed(
                                context, WishlistScreen.routName);
                          },
                        ),
                        CustomListTile(
                          text: "Viewed recently",
                          imagePath: AssetsManager.recent,
                          function: () {
                            Navigator.pushNamed(
                                context, ViewedRecentlyScreen.routName);
                          },
                        ),
                        CustomListTile(
                          text: "Address",
                          imagePath: AssetsManager.address,
                          function: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TitlesTextWidget(
                      label: "Settings",
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: SwitchListTile(
                      secondary: Image.asset(
                        AssetsManager.theme,
                        height: 34,
                      ),
                      title: Text(themeProvider.getIsDarkTheme
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themeValue: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (user == null) {
                    Navigator.pushNamed(context, LoginScreen.routName);
                  } else {
                    await MyAppFunctions.showErrorOrWarningDialog(
                      isError: false,
                      context: context,
                      subtitle: "Are you sure you want to Sign-out?",
                      buttonText: "Sign-out",
                      fct: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          user = null;
                        });
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  foregroundColor: themeProvider.getIsDarkTheme
                      ? Colors.black
                      : Colors.white,
                  elevation: 6,
                  backgroundColor: Colors.red,
                ),
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label: Text(user == null ? "Login" : "Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
