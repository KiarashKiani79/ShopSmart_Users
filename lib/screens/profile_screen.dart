import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsmart_users/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/screens/loading_manager.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import '../consts/theme_data.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../services/my_app_functions.dart';
import '/services/assets_manager.dart';
import '/widgets/subtitle_text.dart';

import '../providers/theme_provider.dart';
import '../widgets/title_text.dart';
import 'auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = "/profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;

  UserModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return LoadingManager(
      isLoading: _isLoading,
      child: Scaffold(
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
              Visibility(
                visible: user == null ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Shimmer.fromColors(
                    period: const Duration(seconds: 5),
                    baseColor: Colors.purple,
                    highlightColor: Colors.red,
                    child: const TitlesTextWidget(
                      label: "Please login to have unlimited access.",
                      maxLines: 1,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: userModel!.userName),
                              const SizedBox(
                                height: 6,
                              ),
                              SubtitleTextWidget(label: userModel!.userEmail)
                            ],
                          )
                        ],
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
                          Visibility(
                            visible: userModel == null ? false : true,
                            child: CustomListTile(
                              text: "All Order",
                              imagePath: AssetsManager.orderSvg,
                              function: () => Navigator.pushNamed(
                                  context, OrdersScreen.routeName),
                            ),
                          ),
                          Visibility(
                            visible: userModel == null ? false : true,
                            child: CustomListTile(
                              text: "Wishlist",
                              imagePath: AssetsManager.wishlistSvg,
                              function: () {
                                Navigator.pushNamed(
                                    context, WishlistScreen.routName);
                              },
                            ),
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
                          if (!mounted) return;
                          Navigator.pushNamed(context, ProfileScreen.routeName);
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
