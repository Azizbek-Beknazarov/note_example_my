import 'package:get/get.dart';
import 'package:note_example_my/routes/route_name.dart';

import '../screens/create_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/edit_screen.dart';
import '../screens/home_screen.dart';

class ProgramPages {
  //massiv
  static final programPages = [
    GetPage(
      name: RouteName.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RouteName.createScreen,
      page: () => CreateScreen(),
    ),
    GetPage(
      name: RouteName.detailScreen,
      page: () => DetailScreen(),
    ),
    GetPage(
      name: RouteName.editScreen,
      page: () => EditScreen(),
    ),
  ];
}
