import 'package:external_dependencies/external_dependencies.dart';

abstract class GetPermissionUsecase {
  Future<bool> call();
}

class GetPermissionUsecaseImpl implements GetPermissionUsecase {
  @override
  Future<bool> call() async {
    final isGranted = await Permission.photos.request().isGranted;

    if (!isGranted) {
      await openAppSettings();
    }

    return isGranted;
  }
}
