import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart' as sql;
import 'package:path/path.dart' as path;

class DB_Helper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'placed.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY ,title TEXT,image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DB_Helper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getDataBase(String table) async {
    final db = await DB_Helper.database();
    return db.query(table);
  }
}
