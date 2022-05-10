import 'package:my_app/Model/profile_instance.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'vncDatabase3.db');

  // open the database
  return await openDatabase(path, version: 2,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('CREATE TABLE profile('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'age INTEGER, '
            'weight REAL, '
            'height REAL'
            ')');
      });
}

Future<ProfileInstance> findById() async {
  Database database = await createDatabase();
  var maps = await database.query('profile');
  final Map<String, dynamic> map = maps[0];
  return ProfileInstance(1, map['name'], map['age'], map['weight'], map['height']);
}

Future<int> save(ProfileInstance profile) async {
  Database database = await createDatabase();
  return database.insert(('profile'), profile.toMap());
}

Future<int> update(ProfileInstance profile) async {
  Database database = await createDatabase();
  return database.update('profile', profile.toMap());
}

void deleteTable() async {
  Database database = await createDatabase();
  database.execute('DROP TABLE IF EXISTS profile');
}