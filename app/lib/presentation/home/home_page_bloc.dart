import 'package:external_dependencies/external_dependencies.dart';

import 'home_page_state.dart';

class HomePageBloc extends BlocBase<HomePageState> {
  HomePageBloc() : super(const HomePageState.initial()) {
    //Permission.photos.request();
  }

  Future<void> saveImage() async {
    emit(const HomePageState.loading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const HomePageState.imageSaved());
  }
}
