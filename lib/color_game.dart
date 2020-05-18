import 'package:flutter/material.dart';

import './emoji.dart';

class ColorGame extends StatefulWidget {
  @override
  _ColorGameState createState() => _ColorGameState();
}

class _ColorGameState extends State<ColorGame> {
  // Map to keep track of scores
  final Map<String, bool> score = {};

  // Choices for game
  final Map choices = {
    'G': Colors.green,
    'Y': Colors.yellow,
    'R': Colors.red,
    'P': Colors.purple,
  };

  // Random seed to shuffle
  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'Score ${score.length}/4',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: () {
              setState(() {
                score.clear();
              });
            },
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((emoji) {
              return Draggable<String>(
                data: emoji,
                child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                feedback: Emoji(emoji: emoji),
                childWhenDragging: Emoji(
                  emoji: ' ',
                ),
              );
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                  ..shuffle(),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            color: Colors.white,
            child: Text('Correct!'),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            color: choices[emoji],
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}
