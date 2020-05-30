import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_Question", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("question", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: true,
          isNullable: false,
          isUnique: true),
      SchemaColumn("answer", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final rows = [
      {'question': 'What is one quarter of 1,000? ', 'answer': '250'},
      {
        'question': 'Which is larger, 50% or five eights?',
        'answer': 'Five eights'
      },
      {
        'question':
            'How many sides, in total, would three triangles and three rectangles have?',
        'answer': '21'
      },
      {
        'question': 'Which ocean surrounds the Maldives?',
        'answer': 'Indian Ocean'
      },
      {
        'question':
            'I\'m called thick when close to the ground, but people smile when I\'m high. What am I?',
        'answer': 'A cloud'
      },
    ];
    for (final row in rows) {
      await database.store.execute(
          "INSERT INTO _Question(question,answer) VALUES (@question,@answer)",
          substitutionValues: {
            'question': row['question'],
            'answer': row['answer']
          });
    }
  }
}
