import 'package:flutter/material.dart';
import 'package:unique_streaming_catalog/widget/content_card.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'series_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLogout = false; // Controla si se muestra el boton de cerrar sesion
  String selectedPlatform = ''; // Plataforma seleccionada para el filtro
  String selectedFilter = ''; // Filtro seleccionado (Peliculas, Series, etc.)
  String searchText = ''; // Texto del buscador

  // Lista de plataformas con logos y nombres
  final List<Map<String, String>> platforms = [
    {'name': 'Netflix', 'logo': 'assets/imagenes/LogoNetflix.jpg'},
    {'name': 'Disney+', 'logo': 'assets/imagenes/Disney_logo.jpg'},
    {'name': 'Prime Video', 'logo': 'assets/imagenes/Prime_logo.jpg'},
    {'name': 'Max', 'logo': 'assets/imagenes/Max_logo.jpg'},

  ];


  // Datos de ejemplo del catalogo
  final List<Map<String, dynamic>> catalog = [
    {
      'title': 'Stranger Things',
      'type': 'Serie',
      'platform': 'Netflix',
      'image': 'assets/imagenes/Stranger Things1.jpg',
      'link': 'https://netflix.com/strangerthings'
    },
    {
      'title': 'El Rey Leon',
      'type': 'Película',
      'platform': 'Disney+',
      'image': 'assets/imagenes/el-rey-leon.avif',
      'link': 'https://disneyplus.com/el rey leon'
    },
    {
      'title': 'The Boys',
      'type': 'Serie',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/the-boys.avif',
      'link': 'https://primevideo.com/theboys'
    },
  ];

  /// Filtrar el catalogo
  List<Map<String, dynamic>> get filteredCatalog {
    return catalog.where((content) {
      final matchesPlatform = selectedPlatform.isEmpty ||
          content['platform'] == selectedPlatform;
      final matchesFilter = selectedFilter.isEmpty ||
          content['type'] == selectedFilter;
      final matchesSearch = searchText.isEmpty ||
          content['title']
              .toLowerCase()
              .contains(searchText.toLowerCase());

      return matchesPlatform && matchesFilter && matchesSearch;
    }).toList();
  }

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
                  selectedPlatform = ''; // Reiniciar filtros
                  selectedFilter = '';
                  searchText = '';
                });
              },
            ),

            // Buscador barra izquierda usuario
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
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


              /// Filtros Interactivos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterButton(
                    label: 'Películas',
                    onTap: () => setState(() {
                      selectedFilter = 'Película';
                    }),
                  ),
                  FilterButton(
                    label: 'Series',
                    onTap: () => setState(() {
                      selectedFilter = 'Serie';
                    }),
                  ),
                  FilterButton(
                    label: 'Animación',
                    onTap: () => setState(() {
                      selectedFilter = 'Animacion';
                    }),
                  ),
                  FilterButton(
                    label: 'Listas',
                    onTap: () => setState(() {
                      selectedFilter = 'Listas';
                    }),
                  ),
                ],
              ),

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

              /// Catalogo
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2; // Default to 2 columns

                    // Si la pantalla es lo suficientemente ancha, se aumentan las columnas
                    if (constraints.maxWidth > 600) {
                      crossAxisCount = 7; // 7 columnas en pantallas más grandes
                    }

                    // Calculo aspecto dinamicamente
                    double aspectRatio = 1.0; // mantener caratulas completas

                    // Ajustar aspecto dependiendo numero columnas
                    if (crossAxisCount > 2) {
                      aspectRatio = 0.35; // mas ancho pantallas mas grandes
                    } else {
                      aspectRatio = 0.7; // menos ancho pantallas mas pequeñas
                    }

                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, // Número de columnas dinámico
                        crossAxisSpacing: 16.0, // Espaciado horizontal
                        mainAxisSpacing: 20.0, // Espaciado vertical
                        childAspectRatio: aspectRatio, // Proporción ajustada para las carátulas
                      ),
                      itemCount: filteredCatalog.length,
                      itemBuilder: (context, index) {
                        final content = filteredCatalog[index];
                        return GestureDetector(
                          onTap: () {
                            if (content['type'] == 'Serie') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SerieScreen(seriesData: content),
                                ),
                              );
                            } else {
                              print('Abrir enlace: ${content['link']}');
                            }
                          },
                          child: ContentCard(content: content),
                        );
                      },
                    );
                  },
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

  FilterButton({required this.label, required void Function() onTap});

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

