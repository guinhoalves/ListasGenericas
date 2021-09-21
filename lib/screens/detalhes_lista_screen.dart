import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/detalhes_lista_controller.dart';
import 'package:listas_genericas/widgets/button_sheet.dart';

class DetalhesListaScreen extends GetView {
  final ct = Get.put(DetalhesListaController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ct,
      builder: (DetalhesListaController controller) {
        return Scaffold(
          backgroundColor: Colors.blueGrey.shade600,
          appBar: AppBar(
            leading: Visibility(
              visible: true,
              child: ct.itensSelecionados.length > 0
                  ? InkWell(
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onLongPress: () {},
                      onTap: () => ct.cancelSelectItensListas(),
                    )
                  : InkWell(
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onLongPress: () {},
                      onTap: () => Get.back(),
                    ),
            ),
            title: ct.itensSelecionados.length > 0
                ? Text("${ct.itensSelecionados.length} Iten(s) Selecionado(s)")
                : Text(
                    ct.lista.titulo.toUpperCase(),
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
            actions: [
              Visibility(
                visible: ct.itensSelecionados.length == 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      ct.nmItemLista.text = ct.itensSelecionados[0].nome;
                      Get.bottomSheet(
                        ButtonSheetWidget(
                          nmLista: ct.nmItemLista,
                          onPressed: () {
                            ct.updateItemLista(ct.nmItemLista.text);
                            ct.nmItemLista.clear();
                          },
                        ),
                        barrierColor: Colors.transparent,
                      );
                    },
                    child: Center(
                      child: Icon(
                        Icons.edit_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: ct.itensSelecionados.length > 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => ct.confirmaDeleteItensListas(ct.itensSelecionados),
                    child: Center(
                      child: Icon(
                        Icons.delete_forever,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
          ),
          body: ListView(
            //padding: EdgeInsets.all(10),
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 120,
                //color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: ct.nmItemLista,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                          labelText: "Nome do Item",
                          labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 60,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Colors.tealAccent,
                            Colors.green.shade600,
                          ],
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => ct.addItemLista(ct.nmItemLista.text),
                        child: Center(
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: Get.height,
                child: ListView.builder(
                  itemCount: ct.lista.itens.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: ct.lista.itens[index].selecionado
                                  ? <Color>[
                                      Colors.grey.shade300,
                                      Colors.grey.shade700,
                                    ]
                                  : ct.lista.itens[index].feito
                                      ? <Color>[
                                          Colors.teal.shade200,
                                          Colors.blue.shade900,
                                        ]
                                      : <Color>[
                                          Colors.yellow.shade200,
                                          Colors.yellow.shade900,
                                        ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Material(
                            child: InkWell(
                              //splashColor: Colors.tealAccent,
                              borderRadius: BorderRadius.circular(25),
                              onLongPress: () => ct.selectedItemLista(ct.lista.itens[index]),
                              onTap: ct.itensSelecionados.length > 0
                                  ? () => ct.selectedItemLista(ct.lista.itens[index])
                                  : () => ct.checkItem(index),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: ct.lista.itens[index].selecionado
                                            ? <Color>[
                                                Colors.grey.shade300,
                                                Colors.grey.shade700,
                                              ]
                                            : ct.lista.itens[index].feito
                                                ? <Color>[
                                                    Colors.teal.shade200,
                                                    Colors.blue.shade900,
                                                  ]
                                                : <Color>[
                                                    Colors.yellow.shade200,
                                                    Colors.yellow.shade900,
                                                  ],
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: ct.lista.itens[index].feito
                                        ? Icon(Icons.check)
                                        : Icon(Icons.priority_high),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    ct.lista.itens[index].nome,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ct.lista.itens[index].selecionado
                                          ? Colors.white
                                          : ct.lista.itens[index].feito
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
