import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_example_my/controller/note_controller.dart';

import 'note_card.dart';

class ListNotes extends StatefulWidget {
  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  final _controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (_controller.listNotes.isEmpty) {
        return Center(
          child: Text('No note yet'),
        );
      }

      return StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(4),
        itemCount: _controller.listNotes.length,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final notes = _controller.listNotes[index];
          return NoteCard( note: notes,index: index,);
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      );
    });
  }
}
