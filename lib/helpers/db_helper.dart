import 'dart:async';

import 'package:merchant/models/list_item.dart';
import 'package:merchant/models/place_model.dart';
import 'package:merchant/models/shopping_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 2;
  Database db;
  static const String ITEM_TABLE = 'items';
  static const String LIST_TABLE = 'list';

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE list(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, ' +
                'FOREIGN KEY(idList) REFERENCES lists(id))');
        database.execute(
            'CREATE TABLE places(id INTEGER PRIMARY KEY, name TEXT, lat DOUBLE, lon DOUBLE, image TEXT)');
      }, version: version);
    }
    return db;
  }

  Future<int> insertList(ShoppingList list) async {
    int id = await db.insert(LIST_TABLE, list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertItem(ListItem items) async {
    int id = await db.insert(ITEM_TABLE, items.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query(LIST_TABLE);
    return List.generate(maps.length, (i) {
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }

  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps =
        await db.query(ITEM_TABLE, where: 'idList = ?', whereArgs: [idList]);
    return List.generate(
        maps.length,
        (index) => ListItem(
              maps[index]['id'],
              maps[index]['idList'],
              maps[index]['name'],
              maps[index]['quantity'],
              maps[index]['note'],
            ));
  }

  Future<int> deleteList(ShoppingList list) async {
    int result =
        await db.delete(ITEM_TABLE, where: "idList = ?", whereArgs: [list.id]);
    result = await db.delete(LIST_TABLE, where: "id = ?", whereArgs: [list.id]);
    return result;
  }

  Future<int> deleteItem(ListItem itemList) async {
    return await db
        .delete(ITEM_TABLE, where: "id = ?", whereArgs: [itemList.id]);
  }

  Future<List<Place>> getPlaces() async {
    final List<Map<String, dynamic>> maps = await db.query('places');
    return List.generate(maps.length, (i) {
      return Place(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['lat'],
        maps[i]['lon'],
        maps[i]['image'],
      );
    });
  }

  Future<int> insertPlace(Place place) async {
    int id = await this.db.insert( 'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }
}
