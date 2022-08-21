import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'contact.dart';
import 'dbcontrollernew.dart';
import 'dp_operation.dart';
import 'dpcontroller.dart';

class ContactDpController implements DpOparetion<Informationcart>{
  Database informationcart=DbControllerproduct().database;
  @override
  Future<int> creat(Object)async {
    // TODO: implement creat
    int newrowid=await informationcart.insert('cartproducts', Object.toMap());
    return newrowid;
    throw UnimplementedError();
  }

  @override
  Future<bool> delet(int id) async {
    int nomdeletrow=await informationcart.delete('cartproducts', where:'id = ?',whereArgs: [id]);
    return nomdeletrow>0;

  }

  @override
  Future<List <Informationcart>> read() async {
    List<Map<String, dynamic>> rows = await informationcart.query('cartproducts');
    return rows.map((rowmap) => Informationcart.fromMap(rowmap)).toList();

  }

  @override
  Future<Informationcart?> show(int id) async {
    List<Map<String, dynamic>> rows = await informationcart.query('cartproducts', where: 'id ?',whereArgs: [id]);
    return rows.isNotEmpty? Informationcart.fromMap(rows.first):null;

  }

  @override
  Future<bool> updat(Object)async {
    int numofupdaterows= await informationcart.update('cartproducts',Object.toMap(),where: 'id = ?',whereArgs: [Object.id]);
  return numofupdaterows>0;}
  //crud=> Creat,Read,Update,Delet

}