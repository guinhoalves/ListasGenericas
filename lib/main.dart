import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:listas_genericas/screens/detalhes_lista_screen.dart';
import 'package:listas_genericas/screens/listas_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(
    GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => ListasScreen()),
        GetPage(name: '/detalhesLista', page: () => DetalhesListaScreen()),
      ],
      theme: ThemeData.dark().copyWith(
        //primaryColor: Colors.teal.shade300,
        primaryColor: Colors.grey[800],
        backgroundColor: Colors.grey,
        accentColor: Colors.black,
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.black,
        ),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
    ),
  );
}
