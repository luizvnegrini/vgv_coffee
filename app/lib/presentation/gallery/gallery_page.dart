import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<String> imgs;
  const GalleryPage({super.key, required this.imgs});

  @override
  Widget build(BuildContext context) {
    if (imgs.isEmpty) {
      return Center(child: const Text("No images found"));
    }

    final backgroundImg = imgs.first;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.file(
            fit: BoxFit.cover,
            File(backgroundImg),
          )
              .animate()
              .scale(
                begin: Offset(1, 1),
                end: Offset(1.8, 1.8),
                delay: 0.seconds,
                duration: 0.seconds,
              )
              .blur(begin: Offset(20, 20), end: Offset(20, 20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FanCarouselImageSlider.sliderType2(
                initalPageIndex: 0,
                isClickable: false,
                imagesLink: imgs,
                isAssets: true,
                imageFitMode: BoxFit.cover,
                userCanDrag: true,
                sliderHeight: MediaQuery.of(context).size.height * 0.63,
                slideViewportFraction: 0.90,
                indicatorActiveColor: Colors.brown,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12)
            ],
          ),
        ],
      ),
    );
  }
}
