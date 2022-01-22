import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:listas_genericas/models/item_lista_model.dart';

import 'package:listas_genericas/models/lista_model.dart';

class DetalhesListaController extends GetxController with GetSingleTickerProviderStateMixin {
  late ListaModel lista;
  late Box listasBox;
  List itens = [].obs;
  TextEditingController nmItemLista = TextEditingController();
  List itensSelecionados = [].obs;
  late final AnimationController animationController;

  @override
  void onClose() {
    exitClear();
    nmItemLista.clear();
    itensSelecionados.clear();
    itens.clear();
    animationController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      lista = Get.arguments[0];
      listasBox = Get.arguments[1];
      if (lista.itens.length > 0) {
        gerarIdItensLista();
      }
    }
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  Future<void> gerarIdItensLista() async {
    int id = 0;
    for (var item in lista.itens) {
      item.id = id;
      id = id + 1;
    }
    update();
  }

  Future<void> addItemLista(String nome) async {
    if (nome.isEmpty) {
      Get.defaultDialog(
        title: "Atenção!",
        middleText: 'Por favor, escolha um nome para o item.',
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              elevation: MaterialStateProperty.all(10),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () => Get.back(),
            child: Text(
              'OK',
            ),
          )
        ],
      );
    } else {
      lista.itens.add(
        ItemListaModel(
          nome: nome,
          tipo: "String",
        ),
      );
      await listasBox.putAt(lista.id!, lista.toJson());
      nmItemLista.clear();
    }
    update();
  }

  Future<void> checkItem(int index) async {
    lista.itens[index].feito == true ? lista.itens[index].feito = false : lista.itens[index].feito = true;
    await listasBox.putAt(lista.id!, lista.toJson());
    update();
  }

  Future<void> removeItens(List itensDelete) async {
    for (var i = 0; i < itensDelete.length; i++) {
      lista.itens.removeAt(
        lista.itens.indexOf(
          lista.itens.firstWhere((e) => e.id == itensDelete[i].id),
        ),
      );
    }
    await listasBox.putAt(lista.id!, lista.toJson());
    itensSelecionados.clear();
    Get.back();
  }

  Future<void> updateItemLista(String nome) async {
    for (var item in lista.itens) {
      if (item.selecionado) {
        item.nome = nome;
        item.selecionado = false;
      }
    }
    await listasBox.putAt(lista.id!, lista.toJson());
    itensSelecionados.clear();
    Get.back();
    update();
  }

  Future<void> confirmaDeleteItensListas(List itensDelete) async {
    Get.defaultDialog(
      title: "Atenção!",
      middleText: 'Tem certeza que deseja excluir ${itensDelete.length} iten(s)?',
      actions: [
        Container(
          height: 40,
          width: 120,
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.blue.shade600,
              onTap: () {
                Get.back();
              },
              onLongPress: () {},
              child: Center(
                child: Text(
                  'CANCELAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            color: Colors.transparent,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
        Container(
          height: 40,
          width: 120,
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.blue.shade600,
              onTap: () async {
                Get.dialog(
                  Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                  barrierDismissible: false,
                  name: 'loading',
                );
                await removeItens(itensDelete);
                Get.back();
                update();
              },
              onLongPress: () {},
              child: Center(
                child: Text(
                  'CONFIRMAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            color: Colors.transparent,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
      ],
    );
  }

  void selectedItemLista(ItemListaModel item) {
    if (item.selecionado) {
      item.selecionado = false;
      itensSelecionados.removeAt(itensSelecionados.indexOf(item));
    } else {
      item.selecionado = true;
      itensSelecionados.add(item);
    }
    update();
  }

  void cancelSelectItensListas() {
    for (var i = 0; i < lista.itens.length; i++) {
      lista.itens[i].selecionado = false;
    }
    itensSelecionados.clear();
    update();
  }

  void exitClear() {
    for (var i = 0; i < lista.itens.length; i++) {
      lista.itens[i].selecionado = false;
    }
    itensSelecionados.clear();
  }
}
