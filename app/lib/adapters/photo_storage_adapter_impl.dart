import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

import '../domain/domain.dart';

class PhotoManagerAdapterImpl implements PhotoStorageAdapter {
  @override
  Future<void> saveImage({
    required String albumName,
    required (Uint8List, String) data,
  }) async {
    final permissionResult = await PhotoManager.requestPermissionExtend();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.${data.$2}';

    if (!permissionResult.isAuth) {
      throw Exception("Permission denied");
    }

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );
    var album = albums.where((a) => a.name == albumName).firstOrNull;

    if (album == null && Platform.isIOS) {
      album = await PhotoManager.editor.darwin.createAlbum(albumName);
    } else if (album == null && Platform.isAndroid) {
      await _createAndroidAlbum(albumName);
      albums = await PhotoManager.getAssetPathList(type: RequestType.image);
      album = albums.firstWhere((a) => a.name == albumName);
    }

    if (album == null) {
      throw Exception("Album not created");
    }

    final asset = await PhotoManager.editor.saveImage(
      data.$1,
      title: imageName,
      filename: imageName,
      relativePath: albumName,
    );

    await PhotoManager.editor.copyAssetToPath(asset: asset, pathEntity: album);
  }

  @override
  Future<List<String>> loadAlbum(String albumName) async {
    await PhotoManager.requestPermissionExtend();
    final List<String> paths = [];
    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    final album = albums.firstWhere((e) => e.name == albumName);
    final assetCount = await album.assetCountAsync;

    if (assetCount > 0) {
      final assets = await album.getAssetListRange(start: 0, end: assetCount);

      await Future.wait(
        assets.map((asset) async => paths.add((await asset.file)?.path ?? '')),
      );
    }

    return paths;
  }

  Future<void> _createAndroidAlbum(String albumName) async {
    final directory = await getExternalStorageDirectory();
    final albumPath = '${directory?.path}/$albumName';

    final albumDirectory = Directory(albumPath);
    if (!albumDirectory.existsSync()) {
      albumDirectory.createSync(recursive: true);
    }
  }
}
