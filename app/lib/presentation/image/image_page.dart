import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ImagePage extends StatelessWidget {
  final Uint8List image;

  const ImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      image,
      fit: BoxFit.cover,
    )
        .animate(
          onComplete: (controller) => controller.reverse(),
        )
        .fadeIn(duration: 350.ms)
        .moveX(
          begin: 0,
          end: 10,
          delay: 2.seconds,
          duration: 15.seconds,
        )
        .scale(
          begin: Offset(1, 1),
          end: Offset(1.3, 1.3),
          delay: 0.seconds,
          duration: 1.minutes,
        );
  }
}
