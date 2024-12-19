import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomePageBloc>()
      ..loadNewImage()
      ..loadCoffeeAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (_, state) => state.maybeWhen(
          imageSaved: () => _bloc.loadNewImage(),
          orElse: () => {},
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (previous, current) => current.maybeWhen(
                  imageLoaded: (_) => true,
                  loadingNewImage: () => true,
                  error: () => true,
                  orElse: () => false,
                ),
                builder: (_, state) => state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  error: () => const Text('Error when load image'),
                  imageLoaded: (image) => Image.memory(image.$1),
                ),
              ),
              BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (previous, current) => current.maybeWhen(
                  coffeeAlbumLoaded: (_) => true,
                  error: () => true,
                  orElse: () => false,
                ),
                builder: (_, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    error: () => const Text('Error when load album'),
                    coffeeAlbumLoaded: (imgs) =>
                        FanCarouselImageSlider.sliderType2(
                      imagesLink: imgs,
                      isAssets: true,
                      imageFitMode: BoxFit.cover,
                      userCanDrag: true,
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => _bloc.loadNewImage(),
                child: Text('Next image'),
              ),
              BlocSelector<HomePageBloc, HomePageState, (Uint8List, String)?>(
                selector: (state) {
                  return state.maybeWhen(
                    imageLoaded: (img) => img,
                    orElse: () => null,
                  );
                },
                builder: (_, img) {
                  return ElevatedButton(
                    onPressed: () => img != null ? _bloc.saveImage(img) : null,
                    child: Text('Save image'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
