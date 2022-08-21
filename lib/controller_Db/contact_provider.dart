
import 'package:flutter/material.dart';
import 'package:smartsstors/controller_Db/contact.dart';

import 'contact_dp_controller.dart';


class ContactProvider extends ChangeNotifier{
  List<Informationcart> contact= <Informationcart>[];
  ContactDpController r= ContactDpController();
  Future<void> read() async{
    contact= await r.read();
notifyListeners();
  }
  Future<bool> creat({required Informationcart c}) async{
    int id= await r.creat(c);
    if(id!=0){
      c.id=id;
      contact.add(c);
      notifyListeners();
    }
    return id!=0;

  }
  Future<bool> delet(int id) async {
    bool deleted = await r.delet(id);
    if (deleted) {
      // contact.removeWhere((element) => element.id==id);
      int index = contact.indexWhere((element) => element.id == id);
      if (index != -1) {
        contact.removeAt(index);
        notifyListeners();
      }
    }
    return deleted;
  }
      Future<bool> updat({required Informationcart contacts}) async{
        bool udating=await r.updat(contacts);
        if(udating) {
          // contact.removeWhere((element) => element.id==id);
          int index = contact.indexWhere((element) =>
          element.id == contacts.id);
          if (index != 1) {
            contact[index]=contacts;
            notifyListeners();
          }
        }
          return udating;

    }

  }

