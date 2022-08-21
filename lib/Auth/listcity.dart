import 'package:flutter/material.dart';
import 'package:smartsstors/api/auth_api_controller.dart';
import 'package:smartsstors/model/productonesearch.dart';

class ListCiyty extends StatefulWidget {
  const ListCiyty({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _ListCiytyState createState() => _ListCiytyState();
}

class _ListCiytyState extends State<ListCiyty> {
  List<Objectproductone> _users = <Objectproductone>[];
  late Future<Objectproductone?> _future;
  bool _isFavorited = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder<Objectproductone?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          _users.add(snapshot.data!);
          return Stack(children: [
            ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  print(_users[index].nameEn);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 20.0,
                      shadowColor: Color(0xFFF4E55AF),
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          // contentPadding: EdgeInsets.zero,
                          leading: Container(
                              width: 70,
                              height: 50,
                              child: Image(
                                  image: NetworkImage(
                                      _users[index].imageUrl.toString()))),
                        ),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.only(top: 300),
              child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 20.0,
                        shadowColor: Color(0xFFF4E55AF),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            // contentPadding: EdgeInsets.zero,
                            leading: Container(
                                width: 70,
                                height: 50,
                                child: Image(
                                    image: NetworkImage(
                                        _users[index].imageUrl.toString()))),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 140),
              child: IconButton(
                iconSize: 30,
                onPressed: () async {
                  await AuthApiController()
                      .favoraite(context, product_id: _users[0].id);
                  setState(() => _users[0].isFavorite = !_users[0].isFavorite!);
                },
                icon: _users[0].isFavorite!
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.red),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
