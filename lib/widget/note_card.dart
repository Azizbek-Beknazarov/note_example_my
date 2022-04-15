import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_example_my/model/note_model.dart';
import 'package:note_example_my/routes/route_name.dart';

final noteColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCard extends StatelessWidget {
  NoteCard({required this.note, required this.index});

  final NoteModel note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = noteColors[index % noteColors.length];

    final time = DateFormat().format(note.createdAt);
    final minHeight = getMinHeight(index);

    return GestureDetector(
      onTap: () => Get.toNamed(RouteName.detailScreen, arguments: note.id),
      child: Card(
        color: color,
        child: Container(
          padding: EdgeInsets.all(9),
          constraints: BoxConstraints(minHeight: minHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(note.id.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,)
              ),
              SizedBox(height: 5),
              Text(note.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),

            ],
          ),
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
