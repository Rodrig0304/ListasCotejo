import 'package:flutter/material.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
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

  final List<String> _activities = [
    'Actividad 1',
    'Actividad 2',
    'Actividad 3',
    'Actividad 4',
    'Actividad 5',
    'Actividad 6',
    'Actividad 7',
    'Actividad 8',
    'Actividad 9',
    'Actividad 10',
  ];

  String _selectedActivity = 'Actividad 1';
  int _currentStudentIndex = 0;

  Map<String, List<Map<String, dynamic>>> _activityRecords = {};

  // Método para marcar si la actividad fue entregada
  void _markActivity(int studentIndex, bool isSubmitted) {
    String status = isSubmitted ? 'Entregada' : 'No Entregada';
    setState(() {
      if (!_activityRecords.containsKey(_selectedActivity)) {
        _activityRecords[_selectedActivity] = List.generate(_students.length,
            (index) => {'name': _students[index], 'status': ''});
      }
      _activityRecords[_selectedActivity]![studentIndex]['status'] = status;
    });
  }

  // Método para agregar una nueva actividad
  void _addActivity() {
    setState(() {
      _activities.add('Nueva Actividad');
      _selectedActivity = _activities.last;
    });
  }

  // Método para borrar una actividad
  void _deleteActivity(String activity) {
    setState(() {
      _activities.remove(activity);
      if (_activities.isNotEmpty) {
        _selectedActivity = _activities[0]; // Cambia a la primera actividad
      } else {
        _selectedActivity = '';
      }
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

  @override
  Widget build(BuildContext context) {
    // Aseguramos que tenemos datos de todos los estudiantes y actividades
    if (!_activityRecords.containsKey(_selectedActivity)) {
      _activityRecords[_selectedActivity] = List.generate(_students.length,
          (index) => {'name': _students[index], 'status': ''});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Actividades',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Alumno: ${_students[_currentStudentIndex]}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            // Selector de actividad
            Text('Selecciona la actividad:',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 177, 177, 177))),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Elige la actividad"),
                    content: DropdownButton<String>(
                      value: _selectedActivity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedActivity = newValue!;
                        });
                        Navigator.of(context).pop();
                      },
                      items: _activities.map((activity) {
                        return DropdownMenuItem<String>(
                          value: activity,
                          child: Text(activity),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              child: Text(
                _selectedActivity,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // Botones para agregar y borrar actividad
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addActivity,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    'Agregar Actividad',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _deleteActivity(_selectedActivity),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    'Borrar Actividad',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Botones de revisar o no entregar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.green),
                  onPressed: () {
                    _markActivity(_currentStudentIndex, true);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    _markActivity(_currentStudentIndex, false);
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
            // Mostrar el historial de actividades para el estudiante actual
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Fila de encabezados de actividades
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Text('Alumno',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Actividad: ${_selectedActivity}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Fila con los estudiantes y botones de revisión
                    for (int i = 0; i < _students.length; i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(_students[i], style: TextStyle(fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.check_circle,
                                      color: _activityRecords[
                                                      _selectedActivity]![i]
                                                  ['status'] ==
                                              'Entregada'
                                          ? Colors.green
                                          : Colors.grey),
                                  onPressed: () => _markActivity(i, true),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      color: _activityRecords[
                                                      _selectedActivity]![i]
                                                  ['status'] ==
                                              'No Entregada'
                                          ? Colors.red
                                          : Colors.grey),
                                  onPressed: () => _markActivity(i, false),
                                ),
                              ],
                            ),
                          ),
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
