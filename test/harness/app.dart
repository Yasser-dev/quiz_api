import 'package:quiz_api/quiz_api.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:quiz_api/quiz_api.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

class Harness extends TestHarness<QuizApiChannel> with TestHarnessORMMixin {
  @override
  Future onSetUp() async {
    await resetData();
  }

  @override
  Future onTearDown() async {}

  @override
  ManagedContext get context => channel.context;
}
