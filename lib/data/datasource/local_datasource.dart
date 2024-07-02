import 'package:crud_local_db/data/models/data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  final String dbName = 'crud.db';
  final String tableName = 'data';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        deskripsi TEXT,
        createdAt TEXT)
        ''',
        );
      },
    );
  }

  //  insert
  Future<int> insertData(Data data) async {
    final db = await _openDatabase();
    return await db.insert(tableName, data.toMap());
  }

  //  get
  Future<List<Data>> getDatas() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, orderBy: 'id DESC');

    return List.generate(maps.length, (i) {
      return Data.fromMap(maps[i]);
    });
  }

  // update
  Future<int> updateDataById(Data data) async {
    final db = await _openDatabase();
    return await db
        .update(tableName, data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }

  // delete
  Future<int> deleteDataById(int id) async {
    final db = await _openDatabase();
    return await db.delete(tableName, where: 'id = ? ', whereArgs: [id]);
  }
}
