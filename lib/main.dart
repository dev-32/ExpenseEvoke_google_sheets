import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
