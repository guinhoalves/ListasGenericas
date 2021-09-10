import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/detalhes_lista_controller.dart';

class DetalhesListaScreen extends GetView {
  final ct = Get.put(DetalhesListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ct.lista.titulo.toUpperCase(),
          style: TextStyle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.teal.shade300,
                Colors.blue.shade700,
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: <Color>[
              Colors.teal.shade300,
              Colors.blue.shade700,
            ],
          ),
        ),
      ),
    );
  }
}
