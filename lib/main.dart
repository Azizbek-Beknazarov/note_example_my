import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_example_my/routes/program_page.dart';
import 'package:note_example_my/routes/route_name.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Note App',
      getPages: ProgramPages.programPages,
      initialRoute: RouteName.homeScreen,

    );
  }
}



