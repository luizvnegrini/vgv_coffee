import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

abstract class SaveImageUsecase {
  Future<Either<Exception, Unit>> call((Uint8List, String) data);
}

class SaveImageUsecaseImpl implements SaveImageUsecase {
  @override
  Future<Either<Exception, Unit>> call((Uint8List, String) data) async {
    try {
      final extension = data.$2.split('/').last;
      var albums = await PhotoManager.getAssetPathList(type: RequestType.image);
      final albumName = 'coffee';
      final filename =
          '$albumName/${DateTime.now().millisecondsSinceEpoch}.$extension';

      if (Platform.isAndroid &&
          !albums.any((album) => album.name == albumName)) {
        await _createAndroidAlbum(albumName);
      }

      await PhotoManager.editor.saveImage(
        data.$1,
        title: albumName,
        filename: filename,
      );

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
