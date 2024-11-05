import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestión Escolar',
      theme: ThemeData(
        primaryColor: Color(0xFF3F51B5), // Azul oscuro
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFC107), // Amarillo
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido al Sistema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                backgroundColor: Color(0xFF3F51B5), // Azul oscuro
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                if (_usernameController.text == 'Rodrigo' &&
                    _passwordController.text == 'rodrigo0907') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenu()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciales incorrectas')),
                  );
                }
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  final List<String> _classrooms = ['Salón 1', 'Salón 2', 'Salón 3', 'Salón 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, Rodrigo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Selecciona un salón'),
              items: _classrooms.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(Icons.check_circle, 'Asistencia', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceScreen()),
                  );
                }),
                _buildMenuButton(Icons.assignment, 'Actividades', () {}),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(Icons.star, 'Conducta', () {}),
                _buildMenuButton(Icons.group, 'Participación', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            backgroundColor: Color(0xFFFFC107), // Amarillo
            textStyle: TextStyle(fontSize: 16),
          ),
          onPressed: onPressed,
          child: Column(
            children: [
              Icon(icon, size: 50),
              Text(label, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

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

  int _currentIndex = 0;
  DateTime _selectedDate = DateTime.now();
  Map<String, List<String>> _attendanceRecords = {};

  void _markAttendance(bool isPresent) {
    String status = isPresent ? 'Presente' : 'Ausente';
    String dateKey = DateFormat('dd/MM/yyyy').format(_selectedDate);

    setState(() {
      if (!_attendanceRecords.containsKey(dateKey)) {
        _attendanceRecords[dateKey] = List.filled(_students.length, '');
      }
      _attendanceRecords[dateKey]![_currentIndex] =
          '${_students[_currentIndex]}: $status';
      _currentIndex++;
    });
  }

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
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateKey = DateFormat('dd/MM/yyyy').format(_selectedDate);
    _attendanceRecords.putIfAbsent(
        dateKey, () => List.filled(_students.length, ''));

    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Usuario: $_username',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona la fecha:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3F51B5), // Azul oscuro
              ),
              child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
            ),
            SizedBox(height: 20),
            if (_currentIndex < _students.length) ...[
              Text(
                'Tomando lista para: ${_students[_currentIndex]}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _markAttendance(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3F51B5), // Azul oscuro
                    ),
                    child: Text('Asistencia'),
                  ),
                  ElevatedButton(
                    onPressed: () => _markAttendance(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3F51B5), // Azul oscuro
                    ),
                    child: Text('Ausente'),
                  ),
                ],
              ),
            ] else ...[
              Text(
                'Lista completada para ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _attendanceRecords[dateKey]?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _attendanceRecords[dateKey]![index],
                        style: TextStyle(fontSize: 16),
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
