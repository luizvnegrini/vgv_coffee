import 'package:external_dependencies/external_dependencies.dart';

import '../../domain/domain.dart';
import 'home_page_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final SaveImageUsecase _saveImageUsecase;
  final GetPermissionUsecase _getPermissionUsecase;

  HomePageBloc({
    required SaveImageUsecase saveImageUsecase,
    required GetPermissionUsecase getPermissionUsecase,
  })  : _saveImageUsecase = saveImageUsecase,
        _getPermissionUsecase = getPermissionUsecase,
        super(const HomePageState.initial());

  Future<void> saveImage() async {
    emit(const HomePageState.loading());

    final isGranted = await _getPermissionUsecase();

    if (isGranted) {
      await _saveImageUsecase();
    }

    emit(const HomePageState.imageSaved());
  }
}
