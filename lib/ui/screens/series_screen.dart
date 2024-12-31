import 'package:flutter/material.dart';

class SerieScreen extends StatefulWidget {
  final Map<String, dynamic> seriesData;

  SerieScreen({required this.seriesData});

  @override
  _SerieScreenState createState() => _SerieScreenState();
}

class _SerieScreenState extends State<SerieScreen> {
  int? selectedSeason; // Temporada seleccionada
  Map<int, List<Map<String, String>>> seasonEpisodes = {
    1: [
      {'title': 'Capítulo 1', 'link': 'https://netflix.com/ep1'},
      {'title': 'Capítulo 2', 'link': 'https://netflix.com/ep2'},
    ],
    2: [
      {'title': 'Capítulo 1', 'link': 'https://netflix.com/s2ep1'},
      {'title': 'Capítulo 2', 'link': 'https://netflix.com/s2ep2'},
    ],
  };

  bool isSeasonWatched(int season) {
    // Logica temporada marcada como vista
    return false;
  }

  bool isEpisodeWatched(String episodeTitle) {
    // Logica capítulo marcado como visto
    return false;
  }

  void markSeasonAsWatched(int season) {
    // Logica marcar toda la temporada como vista
    setState(() {});
  }

  void markEpisodeAsWatched(String episodeTitle) {
    // Logica marcar capítulo como visto
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final series = widget.seriesData;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Detalles de la Serie',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Carátula de la Serie
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

            /// Título y Descripción
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
                        fontWeight: FontWeight.bold),
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
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: seasonEpisodes.keys.map((season) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Temporada $season',
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: isSeasonWatched(season)
                                    ? Colors.green
                                    : Colors.white54,
                              ),
                              onPressed: () {
                                markSeasonAsWatched(season);
                              },
                            ),
                            Icon(
                              selectedSeason == season
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            /// Lista de Capítulos (si hay una temporada seleccionada)
            if (selectedSeason != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: seasonEpisodes[selectedSeason]!
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key + 1;
                  final episode = entry.value;

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: isEpisodeWatched(episode['title']!)
                            ? Colors.green
                            : Colors.white54,
                      ),
                      onPressed: () {
                        markEpisodeAsWatched(episode['title']!);
                      },
                    ),
                    title: GestureDetector(
                      onTap: () {
                        // Abrir plataforma en el capítulo específico
                        launchPlatformLink(episode['link']!);
                      },
                      child: Text(
                        'Capítulo $index: ${episode['title']}',
                        style: TextStyle(
                            color: Colors.blue, decoration: TextDecoration.underline),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void launchPlatformLink(String link) {
    // Abre el enlace en el navegador/plataforma
    print('Abriendo enlace: $link');
  }
}
