import 'package:external_dependencies/external_dependencies.dart';

abstract class LoadCoffeeAlbumUsecase {
  Future<Either<Exception, List<String>>> call();
}

class LoadCoffeeAlbumUsecaseImpl implements LoadCoffeeAlbumUsecase {
  @override
  Future<Either<Exception, List<String>>> call() async {
    await PhotoManager.requestPermissionExtend();
    final List<String> paths = [];
    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    final album = albums.firstWhere((e) => e.name == 'coffee');
    final assetCount = await album.assetCountAsync;

    if (assetCount > 0) {
      final assets = await album.getAssetListRange(start: 0, end: assetCount);

      await Future.wait(
        assets.map((asset) async => paths.add((await asset.file)?.path ?? '')),
      );
    }

    return Right(paths);
  }
}
