import 'package:quiz_api/controllers/questions_contoroller.dart';

import 'quiz_api.dart';

class QuizApiChannel extends ApplicationChannel {
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = QuestionConfig(options.configurationFilePath);
    final database = PostgreSQLPersistentStore(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);
    context = ManagedContext(dataModel, database);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/questions/[:id]").link(() => QuestionsController(context));

    return router;
  }
}

class QuestionConfig extends Configuration {
  QuestionConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}
