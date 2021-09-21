import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:listas_genericas/models/lista_model.dart';

class ListasController extends GetxController {
  List listas = [].obs;
  TextEditingController nmLista = TextEditingController();
  late Box listasBox;
  List listasSelecionadas = [].obs;

  @override
  void onInit() {
    getAllListas();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllListas() async {
    listasBox = await Hive.openBox('listas');
    int id = 0;
    for (var item in listasBox.values) {
      item['id'] = id;
      id = id + 1;
      listas.add(ListaModel.fromJson(item));
    }
    update();
  }

  Future<void> addLista(String nome) async {
    ListaModel lista = ListaModel(
      id: listas.length,
      titulo: nome,
      status: 1,
      selecionado: false,
      itens: [],
    );
    listas.add(lista);
    await listasBox.add(lista.toJson());

    Get.back();
    update();
  }

  Future<void> updateLista(String nome) async {
    ListaModel lista = listas.firstWhere(
      (e) => e.selecionado == true,
    );
    int indexLista = listas.indexOf(
      listas.firstWhere(
        (e) => e.selecionado == true,
      ),
    );
    lista.titulo = nome;
    lista.selecionado = false;
    listasBox.putAt(
      indexLista,
      lista.toJson(),
    );
    listasSelecionadas.clear();
    Get.back();
    update();
  }

  Future<void> removeListas(List listasDelete) async {
    for (var i = 0; i < listasDelete.length; i++) {
      listasBox.deleteAt(
        listas.indexOf(
          listas.firstWhere(
              (e) => e.selecionado == listasDelete[i].selecionado && e.titulo == listasDelete[i].titulo),
        ),
      );
      listas.removeWhere(
          (e) => e.selecionado == listasDelete[i].selecionado && e.titulo == listasDelete[i].titulo);
    }
    listasSelecionadas.clear();
    Get.back();
  }

  Future<void> confirmaDeleteListas(List listasDelete) async {
    Get.defaultDialog(
      title: "Atenção!",
      middleText: 'Tem certeza que deseja excluir ${listasDelete.length} lista(s)?',
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
                await removeListas(listasDelete);
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

  void toggleSelection(ListaModel lst) {
    if (lst.selecionado) {
      lst.selecionado = false;
      listasSelecionadas.removeAt(listasSelecionadas.indexOf(lst));
    } else {
      lst.selecionado = true;
      listasSelecionadas.add(lst);
    }
    update();
  }

  void cancelSelectListas() {
    for (var i = 0; i < listas.length; i++) {
      listas[i].selecionado = false;
    }
    listasSelecionadas.clear();
    update();
  }
}
