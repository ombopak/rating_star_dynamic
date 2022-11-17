import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: RatingBar(
            rating: 3.5,
            ratingCount: 12,
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;

  RatingBar({required this.rating, required this.ratingCount, this.size = 18});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    final realNumber = rating.floor(); // 3.5 => 3
    final partNumber = ((rating - realNumber) * 10)
        .ceil(); // 3.5 - 3 = 5 * 10 = 50 ceil => if 56 then 60

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(
          Icon(
            Icons.star,
            color: Theme.of(context).primaryColor,
            size: size,
          ),
        );
      } else if (i == realNumber) {
        _starList.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
                ClipRect(
                  clipper: _Clipper(part: partNumber),
                  child: Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: size,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        _starList.add(
          Icon(
            Icons.star,
            color: Colors.grey,
            size: size,
          ),
        );
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
