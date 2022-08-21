import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DbController{
  static final DbController _DbController= new DbController._internal();
  DbController._internal();
 late Database _database;
Database get database=> _database;
  factory DbController(){
    return _DbController;
  }
  Future<void> initDataBase()async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= join(directory.path,'app_db.sql');
    _database= await openDatabase(
        path,
        version:3 ,
        onCreate:(Database db,int version) async {
       //   await db.execute('DROP TABLE IF EXISTS cart');
              // 'CREATE TABLE cart('
              // 'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              // 'name TEXT NOT NULL,'
              // 'image TEXT NOT NULL,'
              // 'price INTEGER NOT NULL,'
              // 'count INTEGER NOT NULL'
              // ')');
          await db.execute('DROP TABLE IF EXISTS cart');


    } ,
        onUpgrade:(Database db,int oldVersion,int newVersion)async {
            if(oldVersion==2){
              await db.execute('DROP TABLE IF EXISTS cart');
              print('kkkkkkk');
          }},
        onDowngrade:(Database db,int oldVersion,int newVersion){},


);
  }



}