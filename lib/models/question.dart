import 'package:quiz_api/quiz_api.dart';

class Question extends ManagedObject<_Question> implements _Question {}

class _Question {
  @primaryKey
  int id;

  @Column(unique: true, indexed: true)
  String question;

  String answer;
}
