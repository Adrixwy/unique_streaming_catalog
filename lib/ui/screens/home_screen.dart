import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool showSearchBar = false; // Controla si se muestra el buscador

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
      'link': 'https://netflix.com/strangerthings',
      'isFavorite': false,
      'isWatched': false,
    },
    {
      'title': 'El Rey Leon',
      'type': 'Película',
      'platform': 'Disney+',
      'image': 'assets/imagenes/el-rey-leon.avif',
      'link': 'https://disneyplus.com/el rey leon',
      'isFavorite': false,
      'isWatched': false,
    },
    {
      'title': 'The Boys',
      'type': 'Serie',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/the-boys.avif',
      'link': 'https://primevideo.com/theboys',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Roma',
      'type': 'Película',
      'platform': 'Netflix',
      'image': 'assets/imagenes/roma-2018.avif',
      'link': 'https://netflix.com/roma',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Dune',
      'type': 'Película',
      'platform': 'Max',
      'image': 'assets/imagenes/dune-2021.avif',
      'link': 'https://max.com/dune',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Up',
      'type': 'Película',
      'platform': 'Disney+',
      'image': 'assets/imagenes/up.avif',
      'link': 'https://Disney+.com/up',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Toy-story',
      'type': 'Película',
      'platform': 'Disney+',
      'image': 'assets/imagenes/toy-story.avif',
      'link': 'https://Disney+.com/toy-story',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Joker',
      'type': 'Película',
      'platform': 'Max',
      'image': 'assets/imagenes/joker-2019.avif',
      'link': 'https://max.com/Joker',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'zootropolis',
      'type': 'Película',
      'platform': 'Disney+',
      'image': 'assets/imagenes/zootropolis.avif',
      'link': 'https://Disney+.com/zootropolis',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Wonder Woman 1984',
      'type': 'Película',
      'platform': 'Max',
      'image': 'assets/imagenes/wonder-woman-1984.avif',
      'link': 'https://max.com/wonder-woman',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'La Casa de Papel',
      'type': 'Serie',
      'platform': 'Netflix',
      'image': 'assets/imagenes/La Casa de Papel.jpg',
      'link': 'https://netflix.com/La Casa de Papel',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Shazam!',
      'type': 'Película',
      'platform': 'Max',
      'image': 'assets/imagenes/shazam.avif',
      'link': 'https://max.com/shazam',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'The Irishman',
      'type': 'Película',
      'platform': 'Netflix',
      'image': 'assets/imagenes/el-irlandes-2019.avif',
      'link': 'https://netflix.com/The Irishman',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'The Batman',
      'type': 'Película',
      'platform': 'Max',
      'image': 'assets/imagenes/the-batman.avif',
      'link': 'https://max.com/dune',
      'isFavorite': false,
      'isWatched': false,
    },


    {
      'title': 'The Flight Attendant',
      'type': 'Serie',
      'platform': 'Max',
      'image': 'assets/imagenes/the-flight-attendant.avif',
      'link': 'https://max.com/the-flight-attendant',
      'isFavorite': false,
      'isWatched': false,
    },


    {
      'title': 'Westworld',
      'type': 'Serie',
      'platform': 'Max',
      'image': 'assets/imagenes/Westworld.avif',
      'link': 'https://max.com/Westworld',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'El mañana nunca muere',
      'type': 'Película',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/el-manana-nunca-muere.avif',
      'link': 'https://Prime Video.com/El mañana nunca muere',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'The Trial of the Chicago 7',
      'type': 'Película',
      'platform': 'Netflix',
      'image': 'assets/imagenes/The Trial of the Chicago 7.avif',
      'link': 'https://netflix.com/The Trial of the Chicago 7',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'The Witcher',
      'type': 'Serie',
      'platform': 'Netflix',
      'image': 'assets/imagenes/the-witcher-caratula.jpeg',
      'link': 'https://netflix.com/The Witcher',
      'isFavorite': false,
      'isWatched': false,
    },


    {
      'title': 'Sound of Metal',
      'type': 'Película',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/sound-of-metal.avif',
      'link': 'https://Prime Video.com/Sound of Metal',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': '1917',
      'type': 'Película',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/1917.avif',
      'link': 'https://Prime Video.com/1917',
      'isFavorite': false,
      'isWatched': false,
    },


    {
      'title': 'The Expanse',
      'type': 'Serie',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/the-expanse.avif',
      'link': 'https://Prime Video.com/The Expanse',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Klaus',
      'type': 'Película',
      'platform': 'Netflix',
      'image': 'assets/imagenes/klaus.avif',
      'link': 'https://netflix.com/Klaus',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'Carnival Row',
      'type': 'Serie',
      'platform': 'Prime Video',
      'image': 'assets/imagenes/Carnival Row.avif',
      'link': 'https://Prime Video.com/Carnival Row',
      'isFavorite': false,
      'isWatched': false,
    },


    {
      'title': 'Loki',
      'type': 'Serie',
      'platform': 'Disney+',
      'image': 'assets/imagenes/loki.avif',
      'link': 'https://Disney+.com/Loki',
      'isFavorite': false,
      'isWatched': false,
    },

    {
      'title': 'The Mandalorian',
      'type': 'Serie',
      'platform': 'Disney+',
      'image': 'assets/imagenes/the-mandalorian.avif',
      'link': 'https://Disney+.com/The Mandalorian',
      'isFavorite': false,
      'isWatched': false,
    },
  ];

  // Funcion para lanzar aplicaciones de plataformas de streaming
 /* static const platform = MethodChannel('com.uniqueStreamingCatalog/launch');

  Future<void> _launchApp(String platformName, String link) async {
    try {
      // Llamar al canal MethodChannel para abrir la plataforma correspondiente
      final result = await platform.invokeMethod('openPlatform', {
        'platform': platformName,
        'url': link,
      });
      print(result);
    } on PlatformException catch (e) {
      print("Error al abrir la plataforma: ${e.message}");
    }
  }*/

  /// Filtrar el catalogo
  List<Map<String, dynamic>> get filteredCatalog {
    return catalog.where((content) {
      final matchesPlatform = selectedPlatform.isEmpty ||
          content['platform'] == selectedPlatform;
      final matchesFilter = selectedFilter.isEmpty ||
          content['type'] == selectedFilter ||
          (selectedFilter == 'Favoritos' && content['isFavorite']) ||
          (selectedFilter == 'Vistos' && content['isWatched']);
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

            ///  Icono Listas/filtros con submenus
            PopupMenuButton<String>(
              icon: Icon(Icons.list, color: Colors.white),
              color: Colors.grey[900]?.withOpacity(0.9),
              offset: Offset(0, 50), // El menu  justo debajo del icono
              constraints: BoxConstraints(
                minWidth: 160, // Ancho del menu
                maxWidth: 180, // Máximo ancho del menu
              ),
              onSelected: (String value) {
                setState(() {
                  selectedFilter = value;
                });
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'Película',
                  child: Text('Películas', style: TextStyle(color: Colors.white)),
                ),
                PopupMenuItem<String>(
                  value: 'Serie',
                  child: Text('Series', style: TextStyle(color: Colors.white)),
                ),
                /// Submenu Generos
                PopupMenuItem<String>(
                  child: Submenu(
                    title: 'Géneros',
                    options: ['Animación', 'Comedia', 'Ciencia-Ficción'],
                    onSelect: (value) {
                      setState(() {
                        selectedFilter = value;
                      });
                    },
                  ),
                ),

                /// Submenú Mis Listas
                PopupMenuItem<String>(
                  child: Submenu(
                    title: 'Mis Listas',
                    options: ['Favoritos', 'Vistos'],
                    onSelect: (value) {
                      setState(() {
                        selectedFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            /// Logo y Nombre de la App
            Row(
              children: [
                Image.asset('assets/imagenes/Solo Logo1.jpg', height: 20), SizedBox(width: 8),
                Image.asset('assets/imagenes/Solo Nombre.jpg', height: 20), SizedBox(width: 8),
              ],
            ),

            /// Icono lupa buscador
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  showSearchBar = !showSearchBar;
                });
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
                    AuthService.loggedInUser ?? 'Usuario', // Nombre del usuario registrado
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
        bottom: showSearchBar // Buscador dinamico
            ? PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(color: Colors.white54),
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
        )
            : null,
      ),

      /// Cuerpo Principal
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Filtros por Plataforma (Logos)
              SizedBox(height: 12), // separacion entre barra y filtros
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
              SizedBox(height: 16),

              /// Catalogo
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2; // Default to 2 columns

                    // Si la pantalla es lo suficientemente ancha, se aumentan las columnas
                    if (constraints.maxWidth > 600) {
                      crossAxisCount = 7; // 7 columnas en pantallas mas grandes
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
                        crossAxisCount: crossAxisCount, // Número de columnas dinamico
                        crossAxisSpacing: 16.0, // Espaciado horizontal
                        mainAxisSpacing: 1.0, // Espaciado vertical
                        childAspectRatio: aspectRatio, // Proporcion ajustada para las caratulas
                      ),
                      itemCount: filteredCatalog.length,
                      itemBuilder: (context, index) {
                        final content = filteredCatalog[index];
                        return GestureDetector(
                          onTap: ()  {
                            if (content['type'] == 'Serie') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SerieScreen(seriesData: content),
                                ),
                              );
                            } else {
                              //_launchApp(content['platform'], content['link']);
                            }
                          },
                          child: ContentCard(content: content,
                            onFavoriteTap: () {
                              setState(() {
                                content['isFavorite'] = !content['isFavorite'];// Alternar favorito
                                print('${content['title']} '
                                    '${content['isFavorite'] ? 'añadido a favoritos' : 'eliminado de favoritos'}');

                              });
                            },
                            onWatchedTap: () {
                              setState(() {
                                content['isWatched'] = !content['isWatched']; // Alternar visto
                                print('${content['title']} '
                                    '${content['isWatched'] ? 'marcado como visto' : 'marcado como no visto'}');
                              });
                            },
                          ),
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
  final VoidCallback onTap; // Aseguramos que se reciba una funcion

  FilterButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap, // Llama correctamente a la funcion proporcionada
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

/// ✅ Widget Submenú
class Submenu extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;

  Submenu({required this.title, required this.options, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Text('$title ▶', style: TextStyle(color: Colors.white)),
      color: Colors.grey[900]?.withOpacity(0.9),
      constraints: BoxConstraints(minWidth: 150),
      position: PopupMenuPosition.over,
      offset: Offset(150, 0),  // Desplazamos a la derecha submenu
      itemBuilder: (context) => options.map((option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      onSelected: onSelect,
    );
  }
}