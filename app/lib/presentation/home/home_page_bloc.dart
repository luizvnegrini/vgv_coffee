import 'package:external_dependencies/external_dependencies.dart';

import '../../domain/domain.dart';
import 'home_page_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  final SaveImageUsecase saveImageUsecase;

  HomePageBloc({required this.saveImageUsecase})
      : super(const HomePageState.initial()) {
    //Permission.photos.request();
  }

  Future<void> saveImage() async {
    emit(const HomePageState.loading());
    emit(const HomePageState.imageSaved());
  }
}
