import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, this.pickedImage, required this.function});
  final XFile? pickedImage;
  final Function function;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              18.0,
            ),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        18.0,
                      ),
                    ),
                  )
                : SizedBox(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.width * 0.3,
                    child: Image.file(
                      File(pickedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).primaryColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                function();
              },
              splashColor: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  IconlyBold.camera,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
