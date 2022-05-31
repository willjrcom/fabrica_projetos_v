import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/exercise_instance.dart';
import '../Model/training_instance.dart';

Future<Database> createDatabaseExercise() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'exercise_database1.db');

  // open the database
  return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('CREATE TABLE exercise('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'level INT, '
            'description INT, '
            'totalTime INT, '
            'type TEXT'
            ')');
      });
}

Future<List<ExerciseInstance>> findAllExercises(String type) async {
  Database database = await createDatabaseExercise();
  var maps = await database.query('exercise');

  List<ExerciseInstance> exercises = [];
  for (Map<String, dynamic> map in maps) {
    if (map['type'] == type) {
      exercises.add(exerciseFromMap(map));
    }
  }
  return exercises;
}


void createAllExercises() async {
  Database database = await createDatabaseExercise();
  List<Map<String, dynamic>> maps = await database.query('exercise');

  // pre workout 1
  if (maps.indexWhere((element) => element['id'] == 1) == -1) {
    Map<String, dynamic> preWorkout1 = ExerciseInstance(1, 1, '5min CA', 0, 'pre').toMap();
    await database.insert('exercise', preWorkout1);
  }

  // exercise 1
  if (maps.indexWhere((element) => element['id'] == 1001) == -1) {
    Map<String, dynamic> exercise1 = ExerciseInstance(
        1001, 1, '10x (2min CA + 1min CO)', 35, 'training').toMap();
    await database.insert('exercise', exercise1);
  }

  // exercise 2
  if (maps.indexWhere((element) => element['id'] == 1002) == -1) {
    Map<String, dynamic> exercise2 = ExerciseInstance(
        1002, 1, '10x (3min CA + 1min CO)', 45, 'training').toMap();
    await database.insert('exercise', exercise2);
  }

  // exercise 3
  if (maps.indexWhere((element) => element['id'] == 1003) == -1) {
    Map<String, dynamic> exercise3 = ExerciseInstance(
        1003, 2, '6x (3min CA + 2min CO)', 35, 'training').toMap();
    await database.insert('exercise', exercise3);
  }

  // exercise 4

  if (maps.indexWhere((element) => element['id'] == 1004) == -1) {
    Map<String, dynamic> exercise4 = ExerciseInstance(
        1004, 2, '8x (3min CA + 2min CO)', 45, 'training').toMap();
    await database.insert('exercise', exercise4);
  }

  // exercise 5
  if (maps.indexWhere((element) => element['id'] == 1005) == -1) {
    Map<String, dynamic> exercise5 = ExerciseInstance(
        1005, 3, '5x (3min CA + 3min CO)', 35, 'training').toMap();
    await database.insert('exercise', exercise5);
  }

  // exercise 6
  if (maps.indexWhere((element) => element['id'] == 1006) == -1) {
    Map<String, dynamic> exercise6 = ExerciseInstance(
        1006, 3, '10x (2min CA + 2min CO)', 45, 'training').toMap();
    await database.insert('exercise', exercise6);
  }

  // exercise 7
  if (maps.indexWhere((element) => element['id'] == 1007) == -1) {
    Map<String, dynamic> exercise7 = ExerciseInstance(
        1007, 4, '4x (3min CA + 5min CO)', 37, 'training').toMap();
    await database.insert('exercise', exercise7);
  }

  // exercise 8
  if (maps.indexWhere((element) => element['id'] == 1008) == -1) {
    Map<String, dynamic> exercise8 = ExerciseInstance(
        1008, 4, '5x (3min CA + 5min CO)', 45, 'training').toMap();
    await database.insert('exercise', exercise8);
  }

  // exercise 9
  if (maps.indexWhere((element) => element['id'] == 1009) == -1) {
    Map<String, dynamic> exercise9 = ExerciseInstance(
        1009, 5, '4x (3min CA + 7min CO)', 45, 'training').toMap();
    await database.insert('exercise', exercise9);
  }

  // exercise 10
  if (maps.indexWhere((element) => element['id'] == 1010) == -1) {
    Map<String, dynamic> exercise10 = ExerciseInstance(
        1010, 5, '5x (3min CA + 7min CO)', 55, 'training').toMap();
    await database.insert('exercise', exercise10);
  }
}

void deleteTableTraining() async {
  Database database = await createDatabaseExercise();
  database.execute('DROP TABLE IF EXISTS exercise');
}