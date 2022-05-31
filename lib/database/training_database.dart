import 'dart:convert';
import 'dart:math';

import 'package:my_app/Model/exercise_instance.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/training_instance.dart';
import 'exercise_database.dart';

Future<Database> createDatabaseTraining() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'training_database13.db');

  // open the database
  return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('CREATE TABLE training('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'dataTimeStart TEXT, '
            'dataTimeFinish TEXT, '
            'dataTimeTotal TEXT, '
            'isOpen INTEGER, '
            'exercises TEXT, '
            'totalMinutesToComplete INT'
            ')');
      });
}

Future<double> countFrequencyWeekend() async {
  Database database = await createDatabaseTraining();
  int countDay = 0;
  late DateTime day;
  int min = 0;
  var maps = await database.query('training');
  if (maps.length > 7) {
    min = 8;
  }

  Iterable<Map<String, Object?>> rangeMaps = maps.getRange(maps.length - min, maps.length - 1);
  Duration day1 = const Duration(days: 1);

  for (Map<String, dynamic> map in rangeMaps) {
    DateTime dataTimeStart = DateTime.parse(map['dataTimeStart']);
    if (countDay == 0) {
      day = dataTimeStart;
      countDay ++;
      continue;
    }

    // 2 Treinos no mesmo dia
    if (day.day == dataTimeStart.day) {
      countDay++;
      continue;
    }

    day.add(day1);
    // Dia seguinte
    if (day.day == dataTimeStart.day) {
      countDay++;
    }
  }
  double percentFrequency = countDay * 100 / 7;
  return double.parse(percentFrequency.toStringAsFixed(2));
}

Future<int> countTraining() async {
  Database database = await createDatabaseTraining();
  int count = 0;
  var maps = await database.query('training');
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 0) {
      count++;
    }
  }
  return count;
}

Future<double> countAverageTimeTrainings() async {
  Database database = await createDatabaseTraining();
  double timeCount = 0;
  int count = 0;

  var maps = await database.query('training');
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 0) {
      List<String> dataTimeTotal = map["dataTimeTotal"].toString().split(':');

      double hour = int.parse(dataTimeTotal[0]) * 60;
      int min = int.parse(dataTimeTotal[1]);
      timeCount += hour + min;
      count++;
    }
  }
  if (count == 0) {
    return 0;
  } else {
    double total = timeCount / count;
    return double.parse(total.toStringAsFixed(2));
  }
}

Future<List<TrainingInstance>> findAllTrainingComplete() async {
  Database database = await createDatabaseTraining();
  var maps = await database.query('training');

  List<TrainingInstance> trainings = [];
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 0) {
      trainings.add(trainingFromMap(map));
    }
  }
  return trainings;
}

Future<TrainingInstance?> findTrainingById(int id) async {
  Database database = await createDatabaseTraining();
  var maps = await database.query('training');

  for (Map<String, dynamic> map in maps) {
    if (map['id'] == id) {
      return trainingFromMap(map);
    }
  }
  return null;
}

Future<TrainingInstance?> findOpenTraining() async {
  Database database = await createDatabaseTraining();
  var maps = await database.query('training');
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 1) {
      return trainingFromMap(map);
    }
  }
  return null;
}

Future<TrainingInstance> createTraining(TrainingInstance training) async {
  Database database = await createDatabaseTraining();
  training.dataTimeStart = DateTime.now().toLocal().toString();
  Map<String, dynamic> map = training.toMap();
  map.remove('id');
  map['dataTimeFinish'] = '0';
  map['dataTimeTotal'] = '0';
  map['isOpen'] = 1;

  List<ExerciseInstance> allPreWorkout = await findAllExercises('pre');
  List<ExerciseInstance> allWorkout = await findAllExercises('training');

  final int randomPreWorkout = Random().nextInt(allPreWorkout.length);
  final int randomWorkout = Random().nextInt(allWorkout.length);

  ExerciseInstance preWorkout = allPreWorkout[randomPreWorkout];
  ExerciseInstance workout = allWorkout[randomWorkout];

  String descriptionPreWorkout = preWorkout.description;
  String descriptionWorkout = workout.description;
  String descriptionComplete = "Aquecimento: " + descriptionPreWorkout + "--Treino: " + descriptionWorkout;

  int totalTime = map["totalMinutesToComplete"] = workout.totalTime + preWorkout.totalTime;

  ExerciseInstance newWorkout = ExerciseInstance(
    0,
    workout.level,
    descriptionComplete,
    totalTime,
    workout.type
  );

  training.exercises = map['exercises'] = jsonEncode(newWorkout.toMap());

  await database.insert('training', map);
  return training;
}

Future<TrainingInstance?> finishTraining() async {
  Database database = await createDatabaseTraining();
  var maps = await database.query('training');
  late TrainingInstance training;

  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 1) {
      training = trainingFromMap(map);
    }
  }
  if (training == null) {
    return null;
  }

  var dataTimeStart = DateTime.parse(training.dataTimeStart);
  final dataTimeFinish = DateTime.now().toLocal();

  training.dataTimeFinish = dataTimeFinish.toString();
  training.dataTimeTotal = dataTimeFinish.difference(dataTimeStart).toString();
  training.isOpen = 0;
  String query = training.getUpdateQuery0();

  await database.update('training', training.toMap(), where: 'id = ?', whereArgs: [training.id]);
  return training;
}

Future<int> deleteTraining(TrainingInstance training) async {
  Database database = await createDatabaseTraining();
  return await database.delete('training', where: 'id = ?', whereArgs: [training.id]);
}

void deleteTableTraining() async {
  Database database = await createDatabaseTraining();
  database.execute('DROP TABLE IF EXISTS training');
}