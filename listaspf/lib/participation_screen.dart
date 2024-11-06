import 'package:flutter/material.dart';

class ParticipationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Participación')),
      body: Center(
        child: Text(
          'Pantalla de Participación',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
