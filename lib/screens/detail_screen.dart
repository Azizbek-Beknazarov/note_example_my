import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_example_my/controller/note_controller.dart';
import 'package:note_example_my/routes/route_name.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _controller = Get.find<NoteController>();
  int noteId = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getDetail(noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Detail'),
        actions: [
          IconButton(
              onPressed: () {
                if (_controller.noteDetail == null) return;
                Get.toNamed(RouteName.editScreen,
                    arguments: _controller.noteDetail);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
               showDialog(context: context, builder: (context){
                 return AlertDialog(
                   title: Text('Warning'),
                   content: SingleChildScrollView(
                     child: ListBody(children: [
                       Text('Siz haqiqatdan ham noteni o\'chirmoqchimisiz?'),
                     ],),
                   ),
                   actions: [
                     TextButton(onPressed: (){_controller.deleteNote(noteId);},   child: Text('Yes')),
                     TextButton(onPressed: (){Navigator.of(context).pop();},   child: Text('No')),
                   ],

                 );
               });
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Obx(() {
        if (_controller.isDetailLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.all(12),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 9),
            children: [
              SizedBox(
                height: 9,
              ),
              Text(_controller.noteDetail!.id.toString()),
              Text(_controller.noteDetail!.title),
              SizedBox(
                height: 9,
              ),
              Text(_controller.noteDetail!.description),
              SizedBox(
                height: 8,
              ),
              Text(DateFormat.yMMMMEEEEd()
                  .format(_controller.noteDetail!.createdAt)),
            ],
          ),
        );
      }),
    );
  }
}
