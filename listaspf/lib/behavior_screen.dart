import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BehaviorScreen extends StatefulWidget {
  @override
  _BehaviorScreenState createState() => _BehaviorScreenState();
}

class _BehaviorScreenState extends State<BehaviorScreen> {
  final String _username = "Rodrigo";
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
  List<DateTime> _dates = [DateTime.now()];
  Map<String, List<Map<String, dynamic>>> _behaviorRecords = {};

  // Índice del alumno actual que está registrando conducta
  int _currentStudentIndex = 0;

  // Método para marcar la conducta
  void _markBehavior(int index, bool isGood) {
    String behavior = isGood ? 'Buena conducta' : 'Mala conducta';
    String dateKey = DateFormat('dd/MM/yyyy').format(_selectedDate);

    setState(() {
      if (!_behaviorRecords.containsKey(dateKey)) {
        _behaviorRecords[dateKey] = List.generate(
          _students.length,
          (index) => {'name': _students[index], 'behavior': ''},
        );
      }
      _behaviorRecords[dateKey]![index]['behavior'] = behavior;
    });
  }

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
        if (!_dates.contains(picked)) {
          _dates.add(picked);
        }
      });
    }
  }

  // Método para avanzar al siguiente alumno
  void _nextStudent() {
    if (_currentStudentIndex < _students.length - 1) {
      setState(() {
        _currentStudentIndex++;
      });
    }
  }

  // Método para regresar al alumno anterior
  void _previousStudent() {
    if (_currentStudentIndex > 0) {
      setState(() {
        _currentStudentIndex--;
      });
    }
  }

  // Método para regresar al menú
  void _goToMenu(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Inicializamos los registros de conducta para cada fecha y estudiante
    _dates.forEach((date) {
      String dateKey = DateFormat('dd/MM/yyyy').format(date);
      _behaviorRecords.putIfAbsent(
          dateKey,
          () => List.generate(_students.length,
              (index) => {'name': _students[index], 'behavior': ''}));
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Conducta',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => _goToMenu(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Usuario: $_username',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona la fecha:',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 177, 177, 177)),
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
            Text(
              'Registro de Conducta',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),

            // Mostramos solo el alumno actual
            Text(
              'Alumno: ${_students[_currentStudentIndex]}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Botones para marcar la conducta
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.sentiment_satisfied, color: Colors.green),
                  onPressed: () {
                    _markBehavior(_currentStudentIndex, true);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_dissatisfied, color: Colors.red),
                  onPressed: () {
                    _markBehavior(_currentStudentIndex, false);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Botones para navegar entre los alumnos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _previousStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Anterior',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Mostrar el historial de conducta para todas las fechas
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Encabezado para mostrar cada fecha
                    Row(
                      children: [
                        Text('Alumno',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ..._dates.map((date) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(date),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ],
                    ),

                    // Listado de estudiantes y registros de conducta
                    for (int i = 0; i < _students.length; i++) ...[
                      Row(
                        children: [
                          Text(_students[i], style: TextStyle(fontSize: 16)),
                          ..._dates.map((date) {
                            String dateKey =
                                DateFormat('dd/MM/yyyy').format(date);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.sentiment_satisfied,
                                      color: _behaviorRecords[dateKey]![i]
                                                  ['behavior'] ==
                                              'Buena conducta'
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    onPressed: () => _markBehavior(i, true),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: _behaviorRecords[dateKey]![i]
                                                  ['behavior'] ==
                                              'Mala conducta'
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () => _markBehavior(i, false),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
