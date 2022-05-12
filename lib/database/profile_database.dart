import 'package:my_app/Model/profile_instance.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'profile_database.db');

  // open the database
  return await openDatabase(path, version: 1,
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

Future<ProfileInstance?> findProfileById() async {
  Database database = await createDatabase();
  var maps = await database.query('profile');
  if (maps.isEmpty) {
    return null;
  }
  final Map<String, dynamic> map = maps[0];
  return ProfileInstance(1, map['name'], map['age'], map['weight'], map['height']);
}

Future<int> saveProfile(ProfileInstance profile) async {
  Database database = await createDatabase();
  return database.insert(('profile'), profile.toMap());
}

Future<int> updateProfile(ProfileInstance profile) async {
  Database database = await createDatabase();
  return database.update('profile', profile.toMap());
}

Future<int> deleteProfile(ProfileInstance profile) async {
  Database database = await createDatabase();
  return database.delete('training', where: 'id = ?', whereArgs: [profile.id]);
}

void deleteTableProfile() async {
  Database database = await createDatabase();
  database.execute('DROP TABLE IF EXISTS profile');
}