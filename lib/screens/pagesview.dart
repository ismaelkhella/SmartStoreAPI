import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartsstors/screens/pointclider.dart';
import 'outboardingc.dart';

class pageviewe extends StatefulWidget {
  const pageviewe({Key? key}) : super(key: key);

  @override
  _pagevieweState createState() => _pagevieweState();
}

class _pagevieweState extends State<pageviewe> {
  int _courntpageindex = 0;
  List<String> image = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvF0FPptHCMaOTf1uV_RLDtD4-yQY4RlHQZA&usqp=CAU',
    'https://msry.org/wp-content/uploads/%D8%B5%D9%88%D8%B1-%D8%AD%D9%84%D9%88%D8%A9-4-1.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvF0FPptHCMaOTf1uV_RLDtD4-yQY4RlHQZA&usqp=CAU',
    'https://ccute.cc/wp-content/uploads/2018/07/5378.jpg',
    'https://1.bp.blogspot.com/-rJ_MNOEc5ko/XatbhMou1cI/AAAAAAAABjY/WolXP6btEVkbxNEy8T9CLa5KCuobO7bkwCEwYBhgL/s1600/hdoaa.com%2B%25D8%25B5%25D9%2588%25D8%25B1%2B%25D8%25AE%25D9%2584%25D9%2581%25D9%258A%25D8%25A7%25D8%25AA%2B%25D8%25B7%25D8%25A8%25D9%258A%25D8%25B9%25D9%258A%25D8%25A9%2B%25282%2529.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    double r = MediaQuery.of(context).size.height;
    print(r);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          leading: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white,
                )),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  image[1],
                )),
          ),
          actions: [
            Icon(Icons.seven_k_rounded),
            Icon(Icons.eleven_mp),
            Icon(Icons.eleven_mp_outlined),
          ],
          elevation: 0,
        ),
        body: Stack(children: [
          Container(
            height: 296,
            color: Colors.blue,
          ),
          Padding(
            padding: EdgeInsets.only(top: 46, left: 20, right: 20),
            child: TextField(
              onChanged: (value) {},
              keyboardType: TextInputType.emailAddress,
              // maxLength: 100,
              // minLines: 1,
              decoration: InputDecoration(
                fillColor: Colors.grey,
                filled: true,
                labelStyle: TextStyle(),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                prefixIcon: Icon(Icons.email),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 35,
                  maxWidth: 70,
                ),
                suffixIcon: Icon(Icons.send),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 35,
                  maxWidth: 70,
                ),
                //suffixText: 'valid',
                suffix: Icon(Icons.arrow_forward),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white,
                )),
            height: 160,
            //color: Colors.red,
            margin: EdgeInsets.only(left: 20, top: 232, right: 20),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CarouselSlider.builder(
                itemCount: image.length,
                options: CarouselOptions(
                  onPageChanged: (index, value) {
                    setState(() {
                      _courntpageindex = index;
                    });
                  },
                  //enlargeCenterPage: true,
                  height: double.maxFinite,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  reverse: false,
                  aspectRatio: 5.0,
                ),
                itemBuilder: (context, i, id) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      //ClipRRect for image border radius
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          image[i],
                          width: 280,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    onTap: () {
                      var url = image[i];
                      print('${url.toString()}${' '}${r.toString()}');
                    },
                  );
                },
              ),
            ),
          ),
          Row(children: [
            PointClider(
              marginendend: 5,
              marginendtop: 360,
              marginendstart: 46,
              coloer: _courntpageindex == 0 ? Colors.blue : Colors.grey,
            ),
            PointClider(
              marginendend: 5,
              marginendtop: 360,
              coloer: _courntpageindex == 1 ? Colors.blue : Colors.grey,
            ),
            PointClider(
                marginendend: 5,
                marginendtop: 360,
                coloer: _courntpageindex == 2 ? Colors.blue : Colors.grey),
            PointClider(
                marginendend: 5,
                marginendtop: 360,
                coloer: _courntpageindex == 3 ? Colors.blue : Colors.grey),
            PointClider(
                marginendend: 5,
                marginendtop: 360,
                coloer: _courntpageindex == 4 ? Colors.blue : Colors.grey),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 250, left: 10),
            child: Image(
              image: AssetImage('images/imageone.png'),
            ),
          ),
        ]));
  }
}
