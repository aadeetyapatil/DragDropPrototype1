import 'package:flutter/material.dart';

class Emoji extends StatelessWidget {
  final String emoji;

  Emoji({Key key, this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: Text(
          emoji,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
