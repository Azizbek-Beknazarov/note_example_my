import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_example_my/model/note_model.dart';

import '../controller/note_controller.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputDescription = TextEditingController();

  final _controller = Get.find<NoteController>();

  NoteModel note = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputTitle.text = note.title;
    inputDescription.text = note.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit note'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(17),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: inputTitle,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'The title cannot be empty'
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: inputDescription,
                maxLines: 10,
                minLines: 2,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'The Description cannot be empty'
                    : null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _controller.updateNote(note.id!,inputTitle.text, inputDescription.text);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
