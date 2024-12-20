import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

import '../../domain/domain.dart';
import 'home_page_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final LoadNewImageUsecase _loadNewImageUsecase;
  final SaveImageUsecase _saveImageUsecase;
  final GetPermissionUsecase _getPermissionUsecase;
  final LoadCoffeeAlbumUsecase _loadCoffeeAlbumUsecase;
  HomePageBloc({
    required LoadNewImageUsecase loadNewImageUsecase,
    required SaveImageUsecase saveImageUsecase,
    required GetPermissionUsecase getPermissionUsecase,
    required LoadCoffeeAlbumUsecase loadCoffeeAlbumUsecase,
  })  : _loadNewImageUsecase = loadNewImageUsecase,
        _saveImageUsecase = saveImageUsecase,
        _getPermissionUsecase = getPermissionUsecase,
        _loadCoffeeAlbumUsecase = loadCoffeeAlbumUsecase,
        super(const HomePageState.loading());

  Future<void> loadCoffeeAlbum() async {
    emit(const HomePageState.loadingCoffeeAlbum());

    final result = await _loadCoffeeAlbumUsecase();

    final newState = result.fold(
      (l) => const HomePageState.error(),
      HomePageState.coffeeAlbumLoaded,
    );

    emit(newState);
  }

  Future<void> loadNewImage() async {
    emit(const HomePageState.loading());

    final result = await _loadNewImageUsecase();
    final newState = result.fold(
      (l) => const HomePageState.error(),
      HomePageState.imageLoaded,
    );

    emit(newState);
  }

  Future<void> saveImage((Uint8List, String) data) async {
    emit(const HomePageState.loading());

    final isGranted = await _getPermissionUsecase();

    if (isGranted) {
      final result = await _saveImageUsecase(data);
      final newState = result.fold(
        (l) => const HomePageState.error(),
        (_) => const HomePageState.imageSaved(),
      );

      emit(newState);
    }
  }
}
