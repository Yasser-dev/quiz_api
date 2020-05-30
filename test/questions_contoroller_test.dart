import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();
  test('GET /questions returns 200 (OK)', () async {
    final response = await harness.agent.get('/questions');
    expect(response.statusCode, 200);
  });

  test('GET /invalid returns 404 (NOT FOUND)', () async {
    final response = await harness.agent.get('/blabla');
    expect(response.statusCode, 404);
  });

  test('GET /questions/1 returns 404 (NOT FOUND) for empty db', () async {
    final response = await harness.agent.get('/questions/1');
    expect(response.statusCode, 404);
  });

  test('GET /questions/1 returns 200 (OK) after post', () async {
    await harness.agent.post('questions',
        body: {'question': 'Will this test pass?', 'answer': 'Yes'});
    final response = await harness.agent.get('/questions/1');
    expect(response.statusCode, 200);
  });
  test('POST /questions returns 200 (OK) with valid input', () async {
    final response = await harness.agent.post('/questions',
        body: {'question': 'Will this test pass?', 'answer': 'Yes'});
    expect(response.statusCode, 200);
  });
  test('POST /questions returns 400 (BAD REQUEST) with no input', () async {
    final response = await harness.agent.post('/questions');
    expect(response.statusCode, 400);
  });
  test('POST /questions returns 400 (BAD REQUEST) with no answer entered',
      () async {
    final response = await harness.agent
        .post('/questions', body: {'question': 'Will this test pass?'});
    expect(response.statusCode, 400);
  });
  test('POST /questions returns 400 (BAD REQUEST) with no question entered',
      () async {
    final response =
        await harness.agent.post('/questions', body: {'answer': 'No'});
    expect(response.statusCode, 400);
  });
  test('PUT /questions/1 returns 200 (OK) after posting with valid input',
      () async {
    await harness.agent.post('questions',
        body: {'question': 'Will this test pass?', 'answer': 'Yes'});
    final response = await harness.agent.put('/questions/1',
        body: {'question': 'Will this test pass?', 'answer': 'No'});
    expect(response.statusCode, 200);
  });

  test('PUT /questions/1 returns 404 (NOT FOUND) without posting', () async {
    final response = await harness.agent.put('/questions/1',
        body: {'question': 'Will this test pass?', 'answer': 'No'});
    print(response.statusCode);
    expect(response.statusCode, 404);
  });

  test('DELETE /questions/1 returns 200 (OK) after posting ', () async {
    await harness.agent.post('questions',
        body: {'question': 'Will this test pass?', 'answer': 'Yes'});
    final response = await harness.agent.delete('/questions/1');
    expect(response.statusCode, 200);
  });
  test('DELETE /questions/1 returns 404 (NOT FOUND) without posting ',
      () async {
    final response = await harness.agent.delete('/questions/1');
    expect(response.statusCode, 404);
  });
}
