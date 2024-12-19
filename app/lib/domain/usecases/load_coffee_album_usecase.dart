import 'dart:io';

import 'package:external_dependencies/external_dependencies.dart';

abstract class LoadCoffeeAlbumUsecase {
  Future<Either<Exception, List<String>>> call();
}

class LoadCoffeeAlbumUsecaseImpl implements LoadCoffeeAlbumUsecase {
  @override
  Future<Either<Exception, List<String>>> call() async {
    List<String> paths = [];
    final count = await PhotoManager.getAssetCount(type: RequestType.image);
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    final assets = await albums[0].getAssetListRange(start: 0, end: count);

    for (final asset in assets) {
      final File? file = await asset.file;
      paths.add(file?.path ?? '');
    }

    return Right(paths);
  }
}
