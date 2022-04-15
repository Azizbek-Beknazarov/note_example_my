import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_example_my/controller/note_controller.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputDescription = TextEditingController();

  final _controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Note')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _controller.createNote(inputTitle.text, inputDescription.text);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
