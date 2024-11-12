import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Gestión Escolar',
      theme: ThemeData(
          primaryColor: Color(0xFF3F51B5),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFFC107)),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: LoginScreen(),
    );
  }
}
