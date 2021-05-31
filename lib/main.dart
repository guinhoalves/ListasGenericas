import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/pagina_inicial.dart';

void main() {
  runApp(
    GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => PaginaInicial()),
      ],
      home: PaginaInicial(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
