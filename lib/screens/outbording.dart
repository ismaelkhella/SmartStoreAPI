import 'package:flutter/material.dart';
import 'package:smartsstors/screens/page_view_indecator.dart';

import 'outboardingc.dart';
import 'outboardingcontent.dart';

class outpordingview extends StatefulWidget {
  const outpordingview({Key? key}) : super(key: key);

  @override
  _outpordingviewState createState() => _outpordingviewState();
}

class _outpordingviewState extends State<outpordingview> {
  late PageController _pajcontroleer;
  int _courntpageindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pajcontroleer = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pajcontroleer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            child: Visibility(
              visible: _courntpageindex > 1,
              replacement: TextButton(
                child: Text('Skip'),
                onPressed: () {
                  _pajcontroleer.animateToPage(2,
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
              ),
              child: TextButton(
                child: Text('Start'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login_screen'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                _courntpageindex = value;
              });
            },
            controller: _pajcontroleer,
            children: [
              outbordingcontent(
                image: 'images/imageone.png',
                text: 'Genuine product ',
                text2:
                    'Diversified items of products in life, genuine product, safe',
              ),
              outbordingcontent(
                text: 'Convenient ordering',
                text2:
                    'Order multiple items from multiple brands at the same time',
                image: 'images/imagetwo.png',
              ),
              outbordingcontent(
                text: 'Easy search',
                text2:
                    'Find products easy with Scanning camera, pay with just one camera scan',
                image: 'images/imagethree.png',
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Visibility(
            visible: _courntpageindex != 0,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            child: IconButton(
              onPressed: () {
                _pajcontroleer.previousPage(
                    duration: Duration(seconds: 2), curve: Curves.easeIn);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: _courntpageindex == 0 ? Colors.grey : Colors.black,
            ),
          ),
          Visibility(
            visible: _courntpageindex != 2,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
                onPressed: () {
                  _pajcontroleer.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.easeInOut);
                },
                icon: Icon(Icons.arrow_forward_ios)),
          ),
        ]),

        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageviewindecator(marginend: 10, selected: _courntpageindex == 0),
            pageviewindecator(marginend: 10, selected: _courntpageindex == 1),
            pageviewindecator(marginend: 10, selected: _courntpageindex == 2),
            pageviewindecator(marginend: 10, selected: _courntpageindex == 2),
          ],
        ),

        // SizedBox(height: 20),
        Visibility(
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          visible: _courntpageindex == 2,
          child: Container(
            margin: EdgeInsetsDirectional.only(
                top: 30, bottom: 30, start: 30, end: 30),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/login_screen'),
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
        )
      ]),

    );
  }
}
