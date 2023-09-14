import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/app_constants.dart';
import '../consts/theme_data.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/products/ctg_rounded_widget.dart';
import '../widgets/products/latest_arrival.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
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
              SizedBox(
                height: size.height * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppConstants.bannersImages[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      // alignment: Alignment.center,
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.red,
                          color: Color.fromARGB(255, 255, 202, 202)),
                    ),
                  ),
                ),
              ),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const LatestArrivalProductsWidget();
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
