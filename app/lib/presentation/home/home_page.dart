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
    _bloc = context.read<HomePageBloc>()..loadNewImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: BlocConsumer<HomePageBloc, HomePageState>(
              listener: (_, state) => state.maybeWhen(
                imageSaved: () => _bloc.loadNewImage(),
                orElse: () => {},
              ),
              builder: (_, state) => state.maybeWhen(
                orElse: () => const CircularProgressIndicator(),
                error: () => const Text('Error please try again later'),
                imageLoaded: (image) => Image.memory(image),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _bloc.loadNewImage(),
            child: Text('Next image'),
          ),
          BlocSelector<HomePageBloc, HomePageState, Uint8List?>(
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
    );
  }
}
