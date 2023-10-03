import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../models/features_model.dart';

class DBFeatures{
  static Database? _database;
  static final DBFeatures db = DBFeatures._();
  DBFeatures._();

  Future<Database> get database async{
    if(_database!=null)return _database!;

    _database = await initDB();
    return _database!;
  }


  initDB()async{
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath,'featureDB.db');
    return await openDatabase(path,
    version: 1,
    onCreate: (Database db, int version)async{
      await db.execute(
        '''CREATE TABLE Features (
          id INTEGER PRIMARY KEY, 
          category TEXT, 
          color TEXT, 
          icon TEXT
          )'''
      );
    });
  }


  addNewFeature(FeaturesModel feature)async{
    final db = await database;
    final response = db.insert('Features',feature.toJson());
    return response;
  }

  Future<List<FeaturesModel>>getAllFeatures()async{
    final db = await database;
    final response = await db.query('Features');

    List<FeaturesModel> data = response.isNotEmpty
    ? response.map((e) => FeaturesModel.fromJson(e)).toList()
    : [];

    return data;
  }

  Future<int>updateFeatures(FeaturesModel features)async{
    final db = await database;
    final response = db.update('Features',features.toJson(),
    where: 'id = ?',whereArgs:[features.id]
    );
    return response;
  }
  
}
