import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importamos para la navegación a la pantalla de inicio de sesión

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLogout = false; // Controla si se muestra el botón de cerrar sesión

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(
        backgroundColor: Colors.grey[900], // Color oscuro para la barra superior
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Icono de Casa
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // volver al inicio (o refrescar la pantalla)
              },
            ),

            /// Nombre de Usuario (cerrar sesion)
            GestureDetector(
              onTap: () {
                setState(() {
                  showLogout = !showLogout; // Mostrar/ocultar boton cerrar sesion
                });
              },
              child: Row(
                children: [
                  Text(
                    'NombreUsuario', //aparecera nombre usuario registrado
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Boton Cerrar Sesion (Desplegable)
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Buscador
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),

              /// Filtros Interactivos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterButton(label: 'Películas'),
                    FilterButton(label: 'Series'),
                    FilterButton(label: 'Animación'),
                    FilterButton(label: 'Listas'),
                  ],
                ),
              ),
              SizedBox(height: 20),

              /// Contenido del catalogo (Placeholder por ahora)
              Expanded(
                child: Center(
                  child: Text(
                    'Contenido del Catálogo',
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),

          /// Boton Cerrar Sesión
          if (showLogout)
            Positioned(
              top: kToolbarHeight + 10, // Debajo de la barra superior
              right: 20,
              child: Material(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()), // Volver a Login
                    );
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget Boton de Filtro
class FilterButton extends StatelessWidget {
  final String label;

  FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Logica de filtro
      },
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
