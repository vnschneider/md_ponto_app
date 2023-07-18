import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/ui/home_page.dart';
import 'src/utils/theme.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mermãs Digitais Ponto app',
      theme: lightTheme(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}