
import 'package:flutter/material.dart';

class outbordingcontentl extends StatelessWidget {

  String circle='';


  outbordingcontentl({this.circle=''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 500),
              child: Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(circle,),
                ),
              ),
            )
          ],
        ),


    );
  }
}
