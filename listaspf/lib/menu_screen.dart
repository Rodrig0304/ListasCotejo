import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'activities_screen.dart';
import 'behavior_screen.dart';
import 'participation_screen.dart';
import 'login_screen.dart'; // Asegúrate de importar la pantalla de Login

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Fondo de barra de app negro
        title: Text(
          'Bienvenido, Rodrigo',
          style: TextStyle(color: Colors.white), // Texto blanco
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Texto agregado arriba de los botones
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Salón: Programación Nativa',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Color del texto
                ),
              ),
            ),
            // Botón de regreso al Login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                backgroundColor:
                    const Color.fromARGB(255, 0, 0, 0), // Color del botón
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                elevation: 8, // Sombra ligera
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen())); // Regresar al Login
              },
              child: Text(
                'Regresar al Login',
                style: TextStyle(color: Colors.white), // Texto blanco
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(context, Icons.check_circle, 'Asistencia',
                    AttendanceScreen()),
                _buildMenuButton(context, Icons.assignment, 'Actividades',
                    ActivitiesScreen()),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                    context, Icons.star, 'Conducta', BehaviorScreen()),
                _buildMenuButton(context, Icons.group, 'Participación',
                    ParticipationScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, IconData icon, String label, Widget screen) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            backgroundColor: Color(0xFF1976D2), // Azul de la paleta escolar
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Bordes redondeados más grandes
            ),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold, // Texto en negritas
            ),
            elevation: 10, // Sombra más pronunciada
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: Column(
            children: [
              Icon(
                icon,
                size: 60, // Iconos más grandes
                color: Colors.white, // Icono blanco
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Texto en blanco
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
