import 'package:flutter/material.dart';
import 'plataform_data.dart';

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> content;

  ContentCard({required this.content});

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
                content['image'],
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
                getPlatformLogo(content['platform']),
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
                onTap: () {
                  print('${content['title']} añadido a favoritos');
                },
                child: Icon(
                  Icons.star_border,
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
                onTap: () {
                  print('${content['title']} marcado como visto');
                },
                child: Icon(
                  Icons.visibility_outlined,
                  color: Colors.green,
                  size: 24,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8), // Espaciado entre imagen y título

        /// Titulo debajo  imagen (centrado)
        Text(
          content['title'],
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
