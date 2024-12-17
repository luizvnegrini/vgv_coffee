import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageBloc _bloc;
  final String _imgUrl = 'https://coffee.alexflipnote.dev/random';
  late Key _imgKey;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomePageBloc>();
    _loadNewImage();
  }

  void _loadNewImage() => setState(() => _imgKey = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: BlocListener<HomePageBloc, HomePageState>(
            listener: (context, state) => state.maybeWhen(
              imageSavedState: () => _loadNewImage(),
              orElse: () {},
            ),
            child: Image.network('$_imgUrl?${_imgKey.toString()}'),
          )),
          ElevatedButton(
            onPressed: () => _loadNewImage(),
            child: Text('Next image'),
          ),
          ElevatedButton(
            onPressed: () => _bloc.saveImage(),
            child: Text('Save image'),
          ),
        ],
      ),
    );
  }
}
