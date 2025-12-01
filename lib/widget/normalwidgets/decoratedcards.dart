import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/utils/context_extension.dart';

class Decoratedcards extends StatelessWidget {
  const Decoratedcards({super.key});

  final List<String> title = const ['Web Series', 'Movies', 'TV', 'OTT'];
  final List<Color> colorlist = const [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    // final screenw = context.w;
    return SizedBox(
      height: screenh * 0.22,
      // color: Colors.amberAccent,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 1.9,
          crossAxisCount: 2,
        ),
        itemCount: title.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: colorlist[index],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    title[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
