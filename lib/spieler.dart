import 'package:eldorado/player.dart';
import 'package:flutter/material.dart';

class Spieler extends StatelessWidget {
  const Spieler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spieler'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Colors.black,
                  Colors.blue
                ]
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Player(),
                    ),
                  );
                },
                child: const Text('Spieler 1'),
              ),
              const SizedBox(height: 20),
            ]
        ),
      ),
    );
  }
}
