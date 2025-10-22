import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/data/services/theme_service.dart';
import 'package:writer/utils/constants/app_routes.dart';
import 'package:writer/utils/themes/theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await Hive.openBox('settings');
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Get.put(ThemeService());

    final ThemeData initialLightTheme = themeService.isFallModeActive
        ? AppTheme.lightThemeFall
        : AppTheme.lightTheme;

    final ThemeData initialDarkTheme = themeService.isFallModeActive
        ? AppTheme.darkThemeFall
        : AppTheme.darkTheme;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwiftWrite',
      theme: initialLightTheme,
      darkTheme: initialDarkTheme,
      themeMode: themeService.activeThemeMode,
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}