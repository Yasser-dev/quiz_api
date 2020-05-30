import 'package:quiz_api/quiz_api.dart';
import 'package:quiz_api/models/question.dart';

class QuestionsController extends ResourceController {
  QuestionsController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllQuestions() async {
    final query = Query<Question>(context);
    // query.fetchLimit = 3;
    final questionList = await query.fetch();

    return Response.ok(questionList);
  }

  @Operation.get('id')
  Future<Response> getQuestionById(@Bind.path('id') int id) async {
    // final int id = int.parse(request.path.variables['id']);
    final query = Query<Question>(context)..where((q) => q.id).equalTo(id);
    final question = await query.fetchOne();
    return question != null ? Response.ok(question) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addQuestion(@Bind.body() Question newQuestion) async {
    final query = Query<Question>(context)..values = newQuestion;
    final insertedQuestions = await query.insert();
    return Response.ok(insertedQuestions);
  }

  @Operation.put('id')
  Future<Response> editQuestion(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Question userUpdate) async {
    final query = Query<Question>(context)
      ..values = userUpdate
      ..where((q) => q.id).equalTo(id);
    final updatedQuestion = await query.updateOne();
    return updatedQuestion != null
        ? Response.ok(updatedQuestion)
        : Response.notFound();
  }

  @Operation.delete('id')
  Future<Response> deleteQuestion(@Bind.path('id') int id) async {
    final query = Query<Question>(context)..where((q) => q.id).equalTo(id);
    final deletedQuestion = await query.delete();
    final message = {'message': 'Deleted Question with id: $id'};
    return deletedQuestion != 0 ? Response.ok(message) : Response.notFound();
  }
}
