import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_example_my/controller/note_controller.dart';

import 'note_card.dart';

class ListSearch extends StatefulWidget {
  const ListSearch({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<ListSearch> createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {
  final _controller=Get.find<NoteController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.searchNotes(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(_controller.isLoading.value){
        return const Center(child: CircularProgressIndicator());
      }
      if(_controller.listSearch.isEmpty){
        return Center(child: Text('No item'),);
      }
      return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: _controller.listSearch.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = _controller.listSearch[index];

          return NoteCard(note: note, index: index);
        },);
    });
  }
}
