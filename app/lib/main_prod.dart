import 'core/core.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.prod;
  await runner.main();
}
