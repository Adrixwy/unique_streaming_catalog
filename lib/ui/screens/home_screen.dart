import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLogout = false; // Controla si se muestra el boton de cerrar sesion
  String selectedPlatform = ''; // Plataforma seleccionada para el filtro

  // Lista de plataformas con logos y nombres
  final List<Map<String, String>> platforms = [
    {'name': 'Netflix', 'logo': 'assets/logos/netflix.png'},
    {'name': 'Disney+', 'logo': 'assets/logos/disney.png'},
    {'name': 'Amazon Prime', 'logo': 'assets/logos/prime.png'},
    {'name': 'Max', 'logo': 'assets/logos/max.png'},

  ];

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
            /// Icono Casa
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                setState(() {
                  selectedPlatform = ''; // Reiniciar filtro
                });
              },
            ),

            /// Nombre de Usuario (cerrar sesion)
            GestureDetector(
              onTap: () {
                setState(() {
                  showLogout = !showLogout; // Mostrar/ocultar botón cerrar sesion
                });
              },
              child: Row(
                children: [
                  Text(
                    AuthService.loggedInUser ?? 'Usuario', // Nombre del usuario registrado
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Cuerpo Principal
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

              /// Filtros por Plataforma (Logos)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: platforms.map((platform) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlatform = platform['name']!;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: selectedPlatform == platform['name']
                              ? Colors.blueGrey[800]
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              platform['logo']!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 4),
                            Text(
                              platform['name']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              /// Contenido Filtrado Catalogo
              Expanded(
                child: Center(
                  child: Text(
                    selectedPlatform.isEmpty
                        ? 'Mostrando todo el catálogo'
                        : 'Mostrando contenido de $selectedPlatform',
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),

          /// Boton Cerrar Sesion
          if (showLogout)
            Positioned(
              top: kToolbarHeight + 10,
              right: 20,
              child: Material(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () {
                    AuthService.loggedInUser = null;
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

