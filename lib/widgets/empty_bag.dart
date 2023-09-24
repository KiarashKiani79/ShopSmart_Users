import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/root_screen.dart';

import '../consts/theme_data.dart';
import '../providers/theme_provider.dart';
import 'subtitle_text.dart';
import 'title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.isItOrderBag = false,
  });

  final String imagePath, title, subtitle;
  final String? buttonText;
  final bool isItOrderBag;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return isItOrderBag
        ? Body(
            imagePath: imagePath,
            size: size,
            title: title,
            subtitle: subtitle,
            buttonText: buttonText,
          )
        : Scaffold(
            appBar: AppBar(
              systemOverlayStyle: statusBarTheme(themeProvider),
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
            ),
            body: Body(
              imagePath: imagePath,
              size: size,
              title: title,
              subtitle: subtitle,
              buttonText: buttonText,
            ),
          );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.imagePath,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  final String imagePath;
  final Size size;
  final String title;
  final String subtitle;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.35,
          ),
          const SizedBox(
            height: 20,
          ),
          const TitlesTextWidget(
            label: "Whoops!",
            fontSize: 40,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          SubtitleTextWidget(
            label: title,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SubtitleTextWidget(
              label: subtitle,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buttonText == null
              ? Container()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15)),
                  onPressed: () {
                    Navigator.pushNamed(context, RootScreen.routName);
                  },
                  child: Text(buttonText!),
                ),
        ],
      ),
    );
  }
}
