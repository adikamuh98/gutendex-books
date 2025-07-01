import 'package:flutter/material.dart';
import 'package:palmcode/core/di/injectors.dart';
import 'package:palmcode/features/home/presentation/base_home_screen.dart';
import 'package:palmcode/core/objectbox/objectbox.dart';

late ObjectBox objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCoreDependencies();
  objectBox = await ObjectBox.create();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BaseHomeScreen());
  }
}
