import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/place.dart';

const _tableName = 'user_places';

Future<Database> _openDatabase() async {
  var databasePath = await getDatabasesPath();
  return openDatabase(
    join(databasePath, 'places.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
  );
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]) {
    loadPlaces();
  }

  void loadPlaces() async {
    var db = await _openDatabase();
    var data = await db.query(_tableName);
    state = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();
  }

  addPlace(String title, File image) async {
    var appDir = await getApplicationDocumentsDirectory();
    var newImage = await image.copy('${appDir.path}/${basename(image.path)}');
    var newPlace = Place(title: title, image: newImage);

    var db = await _openDatabase();
    await db.insert(_tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
