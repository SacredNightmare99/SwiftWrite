import 'package:get/get.dart';
import 'package:writer/views/home_screen.dart';
import 'package:writer/views/writer_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/writer', page: () => WriterScreen()),
  ];
}
