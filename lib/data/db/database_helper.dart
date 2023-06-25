import 'package:sqflite/sqflite.dart';

import '../model/restaurant_list.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblBookMark = 'bookmarks';

    Future<Database> _initializeDb() async {
      var path = await getDatabasesPath();
      var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookMark (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating REAL
            )     
          ''');
      }, version: 2);
      return db;
    }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;

    try {
      await db!.insert(_tblBookMark, restaurant.toJson());
    } catch (e) {
      print("Error in insertBookmark: $e");
      return;
    }
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblBookMark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<List<Restaurant>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblBookMark);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;

    await db!.delete(
      _tblBookMark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
