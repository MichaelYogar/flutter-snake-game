import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/snake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Snake snake = Snake(positions: [11, 12, 13, 14]);

  void begin() {
    Timer.periodic(const Duration(milliseconds: 300), (Timer timer) {
      setState(() {
        snake.addTo(snake.positions.last + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    itemCount: 180,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (snake.positions.contains(index)) {
                        return Container(
                          padding: const EdgeInsets.all(1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(color: Colors.blue),
                          ),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(color: Colors.black),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        begin();
                      },
                      child: Text(
                        'Begin',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
