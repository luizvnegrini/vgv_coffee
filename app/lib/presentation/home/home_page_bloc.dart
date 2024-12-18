import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

import '../../domain/domain.dart';
import 'home_page_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final LoadNewImageUsecase _loadNewImageUsecase;
  final SaveImageUsecase _saveImageUsecase;
  final GetPermissionUsecase _getPermissionUsecase;

  HomePageBloc({
    required LoadNewImageUsecase loadNewImageUsecase,
    required SaveImageUsecase saveImageUsecase,
    required GetPermissionUsecase getPermissionUsecase,
  })  : _loadNewImageUsecase = loadNewImageUsecase,
        _saveImageUsecase = saveImageUsecase,
        _getPermissionUsecase = getPermissionUsecase,
        super(const HomePageState.loading());

  Future<void> loadNewImage() async {
    emit(const HomePageState.loading());

    final result = await _loadNewImageUsecase();
    final newState = result.fold(
      (l) => const HomePageState.error(),
      (r) => HomePageState.imageLoaded(r),
    );

    emit(newState);
  }

  Future<void> saveImage(Uint8List rawData) async {
    emit(const HomePageState.loading());

    final isGranted = await _getPermissionUsecase();

    if (isGranted) {
      final result = await _saveImageUsecase(rawData);
      final newState = result.fold(
        (l) => const HomePageState.error(),
        (_) => const HomePageState.imageSaved(),
      );

      emit(newState);
    }
  }
}
