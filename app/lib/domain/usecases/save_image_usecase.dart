import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

abstract class SaveImageUsecase {
  Future<Either<Exception, Unit>> call((Uint8List, String) data);
}

class SaveImageUsecaseImpl implements SaveImageUsecase {
  final String _albumName = 'coffee';

  @override
  Future<Either<Exception, Unit>> call((Uint8List, String) data) async {
    try {
      final permissionResult = await PhotoManager.requestPermissionExtend();
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.${data.$2}';

      if (!permissionResult.isAuth) {
        throw Exception("Permission denied");
      }

      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );
      var album = albums.where((a) => a.name == _albumName).firstOrNull;

      if (album == null && Platform.isIOS) {
        album = await PhotoManager.editor.darwin.createAlbum(_albumName);
      } else if (album == null && Platform.isAndroid) {
        await _createAndroidAlbum(_albumName);
        albums = await PhotoManager.getAssetPathList(type: RequestType.image);
        album = albums.firstWhere((a) => a.name == _albumName);
      }

      if (album == null) {
        throw Exception("Album not created");
      }

      final asset = await PhotoManager.editor.saveImage(
        data.$1,
        title: imageName,
        filename: imageName,
        relativePath: _albumName,
      );

      await PhotoManager.editor
          .copyAssetToPath(asset: asset, pathEntity: album);

      return Right(unit);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

// Função para criar álbum no Android
  Future<void> _createAndroidAlbum(String albumName) async {
    final directory = await getExternalStorageDirectory();
    final albumPath = '${directory?.path}/$albumName';

    final albumDirectory = Directory(albumPath);
    if (!albumDirectory.existsSync()) {
      albumDirectory.createSync(recursive: true);
    }
  }
}
