import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quote_ex/Quote.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  showTimer() {
    Timer(const Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Quote(),
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: const Color.fromARGB(255, 62, 93, 119),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 60,
              width: 60,
              child: Icon(
                Icons.format_quote_sharp,
                size: 70,
              ),
            ), //Image.asset("assets/img/quote.png")),
            Center(
              child: Text(
                'Quotes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Thoughts that are coming from hearts',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
