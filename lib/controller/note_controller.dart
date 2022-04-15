import 'dart:developer';

import 'package:get/get.dart';
import 'package:note_example_my/model/note_model.dart';
import 'package:note_example_my/service/database_service.dart';

class NoteController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isDetailLoading = true.obs;

  RxList<NoteModel> listNotes = <NoteModel>[].obs;
  RxList<NoteModel> listSearch = <NoteModel>[].obs;

  NoteModel? noteDetail;

  searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final searchResult = listNotes
        .where((note) => note.title.toLowerCase().contains(query))
        .toList();
    listSearch.clear();
    listSearch.addAll(searchResult);
  }

  Future getAllNotes() async {
    isLoading.value = true;
    try {
      final notes = await DatabaseProvider.instance.readAllNotes();
      listNotes.clear();
      listNotes.addAll(notes);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future getDetail(int id) async {
    isDetailLoading.value = true;
    try {
      noteDetail = await DatabaseProvider.instance.readNote(id);
      isDetailLoading.value = false;
    } catch (e) {
      isDetailLoading.value = false;
    }
  }

  Future createNote(String title, String description) async {
    try {
      await DatabaseProvider.instance.create(NoteModel(
          title: title, description: description, createdAt: DateTime.now()));
      Get.until((route) => route.isFirst);
      getAllNotes();
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateNote(int id, String title, String description) async {
    try {
      await DatabaseProvider.instance.update(NoteModel(
          id: id,
          title: title,
          description: description,
          createdAt: DateTime.now()));

      Get.back();
      getDetail(id);
      getAllNotes();
    } catch (e) {
      e.toString();
    }
  }

Future deleteNote(int id)async{
    try{
      await DatabaseProvider.instance.delete(id);
      Get.until((route) => route.isFirst);
      getAllNotes();
    }catch(e){
      e.toString();
    }
}
}
