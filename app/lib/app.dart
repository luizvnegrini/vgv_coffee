import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:vgv_coffee/domain/domain.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';

class Startup {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();

    setupDependencyInjectionContainer();

    runApp(_App());
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is Trace) return stack.vmTrace;
      if (stack is Chain) return stack.toTrace().vmTrace;
      return stack;
    };
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomePageBloc(
          loadCoffeeAlbumUsecase: GetIt.I<LoadCoffeeAlbumUsecase>(),
          loadNewImageUsecase: GetIt.I<LoadNewImageUsecase>(),
          saveImageUsecase: GetIt.I<SaveImageUsecase>(),
          getPermissionUsecase: GetIt.I<GetPermissionUsecase>(),
        ),
        child: HomePage(),
      ),
    );
  }
}
