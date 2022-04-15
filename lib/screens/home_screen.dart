import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_example_my/controller/note_controller.dart';
import 'package:note_example_my/routes/route_name.dart';
import 'package:note_example_my/service/database_service.dart';
import 'package:note_example_my/widget/list_search.dart';

import '../widget/list_note.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(NoteController());

  @override
  void initState() {
//
    _controller.getAllNotes();
  }

  @override
  void dispose() {
    DatabaseProvider.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: CustomSearchDelegate()),
              icon: Icon(Icons.search))
        ],
      ),
      body: ListNotes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.createScreen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) =>ListSearch(query: query,);

  @override
  Widget buildSuggestions(BuildContext context) =>ListSearch(query: query,);
}
