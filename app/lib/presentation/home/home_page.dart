import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _imgUrl = 'https://coffee.alexflipnote.dev/random';
  late Key _imgKey;

  @override
  void initState() {
    super.initState();
    _imgKey = UniqueKey();
  }

  void _reloadImage() {
    setState(() {
      _imgKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.network(_imgUrl, key: _imgKey),
          ),
          ElevatedButton(
            onPressed: () => _reloadImage(),
            child: Text('Load new image'),
          ),
          Text(_imgKey.toString()),
        ],
      ),
    );
  }
}
