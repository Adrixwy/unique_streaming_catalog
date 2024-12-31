// Datos de las plataformas con sus respectivos logos
final List<Map<String, String>> platforms = [
  {'name': 'Netflix', 'logo': 'assets/imagenes/Netflix_logo.jpg'},
  {'name': 'Disney+', 'logo': 'assets/imagenes/Disney_logo.jpg'},
  {'name': 'Prime Video', 'logo': 'assets/imagenes/Prime_logo.jpg'},
  {'name': 'Max', 'logo': 'assets/imagenes/Max_logo.jpg'},
];

// Funcion para  el logo de la plataforma
String getPlatformLogo(String platform) {
  final platformData = platforms.firstWhere(
        (p) => p['name'] == platform,
    orElse: () => {'logo': 'assets/imagenes/default_logo.jpg'}, // Imagen por defecto
  );
  return platformData['logo']!;
}
