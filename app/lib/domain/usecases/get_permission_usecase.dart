import 'package:external_dependencies/external_dependencies.dart';

abstract class GetPermissionUsecase {
  Future<bool> call();
}

class GetPermissionUsecaseImpl implements GetPermissionUsecase {
  @override
  Future<bool> call() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (!permission.isAuth) {
      await PhotoManager.openSetting();
    }

    return permission.isAuth;
  }
}
