abstract class SaveImageUsecase {
  Future<void> saveImage();
}

class SaveImageUsecaseImpl implements SaveImageUsecase {
  @override
  Future<void> saveImage() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
