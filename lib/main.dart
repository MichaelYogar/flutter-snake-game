import 'dart:async';
import 'dart:math';

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

enum Direction { up, down, left, right }

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    random = Random();
    generateApple();
  }

  final Snake snake = Snake(positions: [11, 12, 13, 14]);

  bool isStarted = false;

  // Grid
  final int gridSize = 170;
  final rowSize = 10;

  // Starting direction
  Direction direction = Direction.right;

  // Colours
  Color backgroundColour = Colors.white;
  Color gridColour = Color(0xff999c9a);
  Color snakeColour = Colors.black;

  // Snake speed
  final int speedInMilliseconds = 500;

  // from 0 up to gridSize - 1
  late int apple;
  late final Random random;

  // Snake grows every 500 milliseconds
  void begin() {
    Timer.periodic(Duration(milliseconds: speedInMilliseconds), (Timer timer) {
      setState(() {
        changeDirection();
        if (!isStarted) {
          timer.cancel();
        }
      });
    });
  }

  void end() {
    setState(() {
      isStarted = false;
    });
  }

  void generateApple(){
    apple = random.nextInt(gridSize);
    while(snake.positions.contains(apple)){
    apple = random.nextInt(gridSize);
    }
  }


  void changeDirection() {
    setState(() {
      switch (direction) {
        case Direction.up:
          if (snake.positions.last < rowSize) {
            snake.addTo(snake.positions.last - rowSize + gridSize);
          } else {
            snake.addTo(snake.positions.last - rowSize);
          }
          break;
        case Direction.down:
          if (snake.positions.last > gridSize - rowSize) {
            snake.addTo(snake.positions.last + rowSize - gridSize);
          } else {
            snake.addTo(snake.positions.last + rowSize);
          }
          break;
        case Direction.left:
          if (snake.positions.last % rowSize == 0) {
            snake.addTo(snake.positions.last - 1 + rowSize);
          } else {
            snake.addTo(snake.positions.last - 1);
          }
          break;
        case Direction.right:
          if ((snake.positions.last + 1) % rowSize == 0) {
            snake.addTo(snake.positions.last + 1 - rowSize);
          } else {
            snake.addTo(snake.positions.last + 1);
          }
          break;
      }
      if (snake.positions.contains(apple)){
        apple = random.nextInt(gridSize);
      }else{
        snake.positions.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: SizedBox(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  itemCount: gridSize,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowSize,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (snake.positions.contains(index)) {
                      return Container(
                        padding: const EdgeInsets.all(0.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(color: snakeColour),
                        ),
                      );
                    }
                    else if (index == apple){
                      return Container(
                        padding: const EdgeInsets.all(0.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(color: Colors.red),
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.all(0.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: Container(color: gridColour),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 15,
                  onPressed: () {
                    direction = Direction.left;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.black,
                  iconSize: 15,
                  onPressed: () {
                    direction = Direction.right;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  color: Colors.black,
                  iconSize: 15,
                  onPressed: () {
                    direction = Direction.up;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  color: Colors.black,
                  iconSize: 15,
                  onPressed: () {
                    direction = Direction.down;
                  },
                ),
                GestureDetector(
                  onTap: () {
                    begin();
                    setState(() {
                      isStarted = true;
                    });
                  },
                  child: const Text(
                    'Begin',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    end();
                  },
                  child: const Text(
                    'End',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
