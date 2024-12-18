import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

abstract class SaveImageUsecase {
  Future<Either<Exception, Unit>> call(Uint8List data);
}

class SaveImageUsecaseImpl implements SaveImageUsecase {
  @override
  Future<Either<Exception, Unit>> call(Uint8List data) async {
    try {
      final albumName = 'coffee';
      final filename =
          '$albumName/${DateTime.now().millisecondsSinceEpoch}.jpg';

      if (Platform.isIOS) {
        await PhotoManager.editor.darwin.createAlbum(albumName);
      } else if (Platform.isAndroid) {
        await _createAndroidAlbum(albumName);
      }

      await PhotoManager.editor.saveImage(data, filename: filename);
      return Right(unit);
    } catch (e) {
      return left(Exception(e));
    }
  }

  Future<String> _createAndroidAlbum(String albumName) async {
    final directory = await getExternalStorageDirectory();
    final albumPath = '${directory?.path}/$albumName';

    final albumDirectory = Directory(albumPath);
    if (!albumDirectory.existsSync()) {
      albumDirectory.createSync(recursive: true);
    }

    return albumPath;
  }
}
