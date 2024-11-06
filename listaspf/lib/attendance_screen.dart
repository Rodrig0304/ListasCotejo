import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final String _username = "Rodrigo"; // Nombre del usuario que inició sesión
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
  Map<String, List<Map<String, dynamic>>> _attendanceRecords = {};

  // Índice del alumno actual que está pasando lista
  int _currentStudentIndex = 0;

  // Método para marcar la asistencia
  void _markAttendance(int index, bool isPresent) {
    String status = isPresent ? 'Presente' : 'Ausente';
    String dateKey = DateFormat('dd/MM/yyyy').format(_selectedDate);

    setState(() {
      if (!_attendanceRecords.containsKey(dateKey)) {
        _attendanceRecords[dateKey] = List.generate(_students.length,
            (index) => {'name': _students[index], 'status': ''});
      }
      _attendanceRecords[dateKey]![index]['status'] = status;
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

  // Método para actualizar la lista de asistencia
  void _updateAttendance() {
    setState(() {
      _attendanceRecords.clear();
    });
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
    Navigator.pop(context); // Esto regresa a la pantalla anterior (el menú)
  }

  @override
  Widget build(BuildContext context) {
    // Asegurar que tenemos datos de todos los alumnos y fechas
    _dates.forEach((date) {
      String dateKey = DateFormat('dd/MM/yyyy').format(date);
      _attendanceRecords.putIfAbsent(
          dateKey,
          () => List.generate(_students.length,
              (index) => {'name': _students[index], 'status': ''}));
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Color negro
        title: Text(
          'Asistencia',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => _goToMenu(context), // Regresar al menú
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _updateAttendance,
          ),
        ],
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
                backgroundColor: Colors.black, // Botón negro
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate),
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text(
              'Pase de Lista',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Mostramos solo el alumno actual
            Text(
              'Alumno: ${_students[_currentStudentIndex]}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Botones para marcar la asistencia
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.green),
                  onPressed: () {
                    _markAttendance(_currentStudentIndex, true);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    _markAttendance(_currentStudentIndex, false);
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
                    backgroundColor: Colors.black, // Botón negro
                  ),
                  child: Text(
                    'Anterior',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Botón negro
                  ),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Mostrar el historial de asistencias para la fecha seleccionada
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Fila de encabezados de fechas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Text('Alumno',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ..._dates.map((date) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(DateFormat('dd/MM/yyyy').format(date),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Fila con los estudiantes y botones de presencia/ausencia
                    for (int i = 0; i < _students.length; i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(_students[i], style: TextStyle(fontSize: 16)),
                          ..._dates.map((date) {
                            String dateKey =
                                DateFormat('dd/MM/yyyy').format(date);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check_circle,
                                        color: _attendanceRecords[dateKey]![i]
                                                    ['status'] ==
                                                'Presente'
                                            ? Colors.green
                                            : Colors.grey),
                                    onPressed: () => _markAttendance(i, true),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.cancel,
                                        color: _attendanceRecords[dateKey]![i]
                                                    ['status'] ==
                                                'Ausente'
                                            ? Colors.red
                                            : Colors.grey),
                                    onPressed: () => _markAttendance(i, false),
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
