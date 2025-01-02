import 'package:flutter/material.dart';
import 'plataform_data.dart';

class ContentCard extends StatefulWidget {
  final Map<String, dynamic> content;
  final VoidCallback onFavoriteTap;
  final VoidCallback onWatchedTap;


  ContentCard({
    required this.content,
    required this.onFavoriteTap,
    required this.onWatchedTap,
  });

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool isFavorite = false; // Estado para la estrella
  bool isWatched = false; // Estado para el ojo


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Imagen con iconos superpuestos
        Stack(
          children: [
            /// Imagen de la caratula
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                widget.content['image'],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 210, // Altura fija ver caratula completa
              ),
            ),

            /// Logo  plataforma (abajo  izquierda)
            Positioned(
              bottom: 4,
              left: 4,
              child: Image.asset(
                getPlatformLogo(widget.content['platform']),
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),

            /// Estrella agregar  favoritos (arriba  izquierda)
            Positioned(
              top: 4,
              left: 4,
              child: GestureDetector(
                onTap: widget.onFavoriteTap,// Alternar estado favorito
                child: Icon(
                  widget.content['isFavorite'] ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
            ),

            /// Icono de ojo  marcar como visto (arriba  derecha)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: widget.onWatchedTap, // Alternar estado visto
                child: Icon(
                  widget.content['isWatched'] ? Icons.visibility : Icons.visibility_outlined,
                  color: widget.content['isWatched'] ? Colors.green : Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8), // Espaciado entre imagen y título

        /// Titulo debajo  imagen (centrado)
        Text(
          widget.content['title'],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
