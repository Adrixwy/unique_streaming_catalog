import 'package:flutter/material.dart';
import 'auth_service.dart';

class SerieScreen extends StatefulWidget {
  final Map<String, dynamic> seriesData;

  SerieScreen({required this.seriesData});

  @override
  _SerieScreenState createState() => _SerieScreenState();
}

class _SerieScreenState extends State<SerieScreen> {
  int? selectedSeason; // Temporada seleccionada
  String searchText = ''; // Texto del buscador
  bool showLogout = false; // Controla si se muestra el boton de cerrar sesion

  // Control de estado para temporadas y capítulos vistos
  Map<int, bool> watchedSeasons = {};
  Map<String, bool> watchedEpisodes = {};

  // Datos de ejemplo de episodios por temporada
  Map<String, Map<int, Map<String, dynamic>>> seriesSeasonsData = {
    'Stranger Things': {
      1: {
        'image': 'assets/imagenes/Stranger Things temporada-1.avif',
        'episodes': [
          {'season': 1, 'chapter': 1,'title': 'Capítulo 1', 'duration': 50, 'link': 'https://netflix.com/ep1'},
          {'season': 1, 'chapter': 2,'title': 'Capítulo 2', 'duration': 50, 'link': 'https://netflix.com/ep2'},
        ],
      },
      2: {
        'image': 'assets/imagenes/Stranger Things temporada-2.avif',
        'episodes': [
          {'season': 2, 'chapter': 1,'title': 'Capítulo 1', 'duration': 50, 'link': 'https://netflix.com/s2ep1'},
          {'season': 2, 'chapter': 2,'title': 'Capítulo 2', 'duration': 50, 'link': 'https://netflix.com/s2ep2'},
        ],
      },
    },
    'The Boys': {
      1: {
        'image': 'assets/imagenes/The Boys temporada-1.avif',
        'episodes': [
          {'season': 1, 'chapter': 1,'title': 'Capítulo 1', 'duration': 48, 'link': 'https://netflix.com/ep1'},
          {'season': 1, 'chapter': 2,'title': 'Capítulo 2', 'duration': 48, 'link': 'https://netflix.com/ep2'},
        ],
      },
      2: {
        'image': 'assets/imagenes/The Boys temporada-2.avif',
        'episodes': [
          {'season': 2, 'chapter': 1,'title': 'Capítulo 1', 'duration': 48, 'link': 'https://netflix.com/s2ep1'},
          {'season': 2, 'chapter': 2,'title': 'Capítulo 2', 'duration': 48, 'link': 'https://netflix.com/s2ep2'},
        ],
      },
    },
  };

  /// Comprueba si una temporada esta marcada como vista
  bool isSeasonWatched(int season) {
    return watchedSeasons[season] ?? false;
  }

  /// Comprueba si un capitulo esta marcado como visto
  bool isEpisodeWatched(int season, int chapter) {
    String key = 'T${season}E${chapter}';
    return watchedEpisodes[key] ?? false;
  }


  /// Marca una temporada como vista
  void toggleSeasonWatched(int season) {
    setState(() {
      watchedSeasons[season] = !(watchedSeasons[season] ?? false);
    });
  }

  /// Marca un capítulo como visto
  void toggleEpisodeWatched(int season, int chapter) {
    String key = 'T${season}E${chapter}';
    setState(() {
      watchedEpisodes[key] = !(watchedEpisodes[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final series = widget.seriesData;
    final String seriesTitle = series['title']; // Título de la serie seleccionada
    final Map<int, Map<String, dynamic>> seasonData = seriesSeasonsData[seriesTitle] ?? {};


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Boton Home
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            /// Buscador barra izquierda usuario
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

            /// Nombre de Usuario (Cerrar sesion)
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Caratula de la Serie
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(series['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                /// Titulo y Descripcion
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        series['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descripción de la serie aquí. Breve sinopsis o detalles importantes sobre la serie.',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                /// Lista de Temporadas
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Temporadas:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: seasonData.keys.map((season) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeason = selectedSeason == season ? null : season;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            /// Carátula de la Temporada
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(seasonData[season]?['image'] ?? series['image']),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            SizedBox(width: 10),

                            /// Información de la Temporada
                            Expanded(
                              child: Text(
                                'Temporada $season',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            /// Ojo Interactivo
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: isSeasonWatched(season)
                                    ? Colors.green
                                    : Colors.white54,
                              ),
                              onPressed: () {
                                toggleSeasonWatched(season);
                              },
                            ),

                            Icon(
                              selectedSeason == season
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                /// Lista de Capítulos
                if (selectedSeason != null)
                  Column(
                    children: (seasonData[selectedSeason]?['episodes'] as List).map<Widget>((episode) {
                      return ListTile(
                        leading: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: isEpisodeWatched(episode['season'], episode['chapter'])
                                ? Colors.green
                                : Colors.white54,
                          ),
                          onPressed: () {
                            toggleEpisodeWatched(episode['season'], episode['chapter']); // Llamada a la funcion
                          },
                        ),
                        title: Text(
                          'T${episode['season']} - E${episode['chapter']}  ${episode['title']}  '
                              '${episode['duration']} mins', // Título con temporada y capítulo
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),

          /// Botón Cerrar Sesión
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
                    Navigator.pushReplacementNamed(context, '/login');
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

  void launchPlatformLink(String link) {
    print('Abriendo enlace: $link');
  }
}