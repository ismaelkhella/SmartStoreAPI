import 'package:flutter/material.dart';

class outbordingcontent extends StatelessWidget {
  String image = '';
  String text = '';
  String text2 = '';

  outbordingcontent(
      {this.image = '',
      this.text = '',
      this.text2 =
          ''}); // const outbordingcontent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Image(
                image: AssetImage(image),
                width: 392,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 232,
              child: Text(
                text2,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
