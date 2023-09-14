import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../consts/app_constants.dart';

class HomeSwiper extends StatelessWidget {
  const HomeSwiper({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
