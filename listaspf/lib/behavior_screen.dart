import 'package:flutter/material.dart';

class BehaviorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conducta')),
      body: Center(
        child: Text(
          'Pantalla de Conducta',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
