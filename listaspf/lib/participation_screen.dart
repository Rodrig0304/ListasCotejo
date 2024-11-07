import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParticipationScreen extends StatefulWidget {
  @override
  _ParticipationScreenState createState() => _ParticipationScreenState();
}

class _ParticipationScreenState extends State<ParticipationScreen> {
  final List<String> _students = [
    'Alumno 1',
    'Alumno 2',
    'Alumno 3',
    'Alumno 4',
    'Alumno 5',
    'Alumno 6',
    'Alumno 7',
    'Alumno 8',
    'Alumno 9',
    'Alumno 10',
  ];

  DateTime _selectedDate = DateTime.now();
  int _totalParticipationPoints = 10; // Valor inicial del total de puntos
  Map<String, int> _participationScores =
      {}; // Puntajes obtenidos por cada alumno

  // Método para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Método para asignar puntos a un alumno
  void _setParticipationScore(String student, int points) {
    setState(() {
      _participationScores[student] = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Selección de fecha
            Text(
              'Selecciona la fecha:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate),
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            // Configuración del total de puntos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total de puntos para participación:',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<int>(
                  value: _totalParticipationPoints,
                  items: List.generate(21, (i) => i + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _totalParticipationPoints = value;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Título de Participación
            Text(
              'Evaluación de Participación',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),

            // Lista de alumnos con puntajes
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  String student = _students[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nombre del alumno
                          Text(
                            'Alumno: $student',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),

                          // Total de puntos y puntaje asignado
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total: $_totalParticipationPoints puntos'),
                              Row(
                                children: [
                                  Text('Obtenidos: '),
                                  DropdownButton<int>(
                                    value: _participationScores[student] ?? 0,
                                    items: List.generate(
                                      _totalParticipationPoints + 1,
                                      (i) => DropdownMenuItem(
                                        value: i,
                                        child: Text('$i'),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value != null) {
                                        _setParticipationScore(student, value);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
