import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/training_instance.dart';

Future<Database> createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'training_database9.db');

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
            'isOpen INTEGER'
            ')');
      });
}

Future<int> countTraining() async {
  Database database = await createDatabase();
  int count = 0;
  var maps = await database.query('training');
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 0) {
      count++;
    }
  }
  return count;
}

Future<List<TrainingInstance>> findAllTraining() async {
  Database database = await createDatabase();
  var maps = await database.query('training');

  List<TrainingInstance> trainings = [];
  for (var i = 0; i < maps.length; i++) {
    trainings.add(trainingFromMap(maps[i]));
  }
  return trainings;
}

Future<TrainingInstance?> findTrainingById(int id) async {
  Database database = await createDatabase();
  var maps = await database.query('training');

  for (Map<String, dynamic> map in maps) {
    if (map['id'] == id) {
      return trainingFromMap(map);
    }
  }
  return null;
}

Future<TrainingInstance?> findOpenTraining() async {
  Database database = await createDatabase();
  var maps = await database.query('training');
  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 1) {
      return trainingFromMap(map);
    }
  }
  return null;
}

Future<TrainingInstance> createTraining(TrainingInstance training) async {
  Database database = await createDatabase();
  training.dataTimeStart = DateTime.now().toLocal().toString();
  Map<String, dynamic> map = training.toMap();
  map.remove('id');
  map['dataTimeFinish'] = '0';
  map['dataTimeTotal'] = '0';
  map['isOpen'] = 1;
  await database.insert('training', map);
  return training;
}

Future<TrainingInstance?> finishTraining() async {
  Database database = await createDatabase();
  var maps = await database.query('training');
  TrainingInstance training;

  for (Map<String, dynamic> map in maps) {
    if (map['isOpen'] == 1) {
      training = trainingFromMap(map);

      var dataTimeStart = DateTime.parse(training.dataTimeStart);
      final dataTimeFinish = DateTime.now().toLocal();
      training.dataTimeFinish = dataTimeFinish.toString();
      training.dataTimeTotal = dataTimeFinish.difference(dataTimeStart).toString();
      training.isOpen = 0;
      await database.update('training', training.toMap(), where: 'id = ?', whereArgs: [training.id]);
      return training;
    }
  }
  return null;
}

Future<int> updateTraining(TrainingInstance training) async {
  Database database = await createDatabase();
  return await database.update('training', training.toMap(), where: 'id = ?', whereArgs: [training.id]);
}

Future<int> deleteTraining(TrainingInstance training) async {
  Database database = await createDatabase();
  return await database.delete('training', where: 'id = ?', whereArgs: [training.id]);
}

void deleteTableTraining() async {
  Database database = await createDatabase();
  database.execute('DROP TABLE IF EXISTS training');
}