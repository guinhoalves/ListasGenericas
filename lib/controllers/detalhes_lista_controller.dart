import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:listas_genericas/models/item_lista_model.dart';

import 'package:listas_genericas/models/lista_model.dart';

class DetalhesListaController extends GetxController {
  late ListaModel lista;
  late Box listasBox;
  List listas = [].obs;
  TextEditingController nmItemLista = TextEditingController();

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      lista = Get.arguments[0];
      getAllListas();
    }

    super.onInit();
  }

  Future<void> getAllListas() async {
    listasBox = await Hive.openBox('listas');

    update();
  }

  Future<void> addItemLista(String nome) async {
    lista.itens.add(ItemListaModel(nome: nome, tipo: "String"));
    await listasBox.putAt(lista.id!, lista.toJson());

    Get.back();
    update();
  }
}
