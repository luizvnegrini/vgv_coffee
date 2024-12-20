import 'package:external_dependencies/external_dependencies.dart';

import '../domain.dart';

abstract class LoadCoffeeAlbumUsecase {
  Future<Either<Exception, List<String>>> call();
}

class LoadCoffeeAlbumUsecaseImpl implements LoadCoffeeAlbumUsecase {
  final CoffeeImageRepository repository;

  LoadCoffeeAlbumUsecaseImpl({required this.repository});

  @override
  Future<Either<Exception, List<String>>> call() async {
    return await repository.loadAlbum();
  }
}
