import 'dart:async';
import 'package:flutter/material.dart';
import 'functions.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _Screen createState() => _Screen();
}

class _Screen extends State<Player> {
  final List<int> items = List<int>.generate(18, (int index) => index + 1);
  int? selectedCardType;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void checkBuy(int cardid) {
    String card = Functions.getcardbyid(cardid);
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context, Functions.buyCard(cardid, context));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Buy $cardid?"),
      content: Text("Möchtest du diese Karte kaufen: $card"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> wheelItems = items.map((int value) {
      final color = Color.lerp(
        Colors.purple[600],
        Colors.purple[300],
        value / items.length,
      )!;
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedCardType = value;
          });
          _timer?.cancel();
          _timer = Timer(const Duration(milliseconds: 500), () {
            checkBuy(value);
          });
        },
        child: Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              value.toString(),
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      );
    }).toList();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: wheelItems,
          ),
        ),
      ),
    );
  }
}