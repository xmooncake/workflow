import 'package:rfid77workflow/bootstrap.dart';
import 'package:rfid77workflow/features/app/app.dart';
import 'package:rfid77workflow/features/hive/hive.service.dart';

Future<void> main() async {
  await HiveService.initialize();
  // await HiveService.addMockupEvaluations();

  bootstrap(() => const App());
}
