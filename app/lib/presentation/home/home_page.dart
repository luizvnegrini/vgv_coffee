import 'package:flutter/material.dart';

import '../../core/core.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
      ),
      body: Center(
        child: Image.network(
          'https://coffee.alexflipnote.dev/random',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 50);
          },
          fit: BoxFit.cover, // Ajusta a imagem ao espaço disponível
        ),
      ),
    );
  }
}
