import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/app_constants.dart';
import '../consts/theme_data.dart';
import '../providers/products_provider.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/home_swiper.dart';
import '../widgets/products/ctg_rounded_widget.dart';
import '../widgets/products/latest_arrival.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      // appBar
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
      // body
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              // banners swiper
              HomeSwiper(size: size),
              const SizedBox(
                height: 15.0,
              ),
              // Latest arrival title
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TitlesTextWidget(label: "Latest arrival"),
              ),
              const SizedBox(
                height: 5.0,
              ),
              // Latest arrival products
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productsProvider.getProducts.length < 10
                        ? productsProvider.getProducts.length
                        : 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: productsProvider.getProducts[index],
                          child: const LatestArrivalProductsWidget());
                    }),
              ),
              // Categories title
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: TitlesTextWidget(label: "Categories"),
              ),
              const SizedBox(
                height: 13.0,
              ),
              // Categories list
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    image: AppConstants.categoriesList[index].image,
                    name: AppConstants.categoriesList[index].name,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
