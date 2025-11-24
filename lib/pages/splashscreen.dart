import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/utls/context_extension.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenw = context.w;
    final screenh = context.h;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Lottie.asset(
          '/images/splinter.json',
          width: screenw,
          height: screenh,
          onLoaded: (animationinfo) {
            Future.delayed(
              animationinfo.duration,
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              ),
            );
          },
        ),
      ),
    );
  }
}
