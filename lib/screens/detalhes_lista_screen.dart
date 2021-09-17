import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/detalhes_lista_controller.dart';

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
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                              colors: <Color>[
                                Colors.teal.shade300,
                                Colors.blue.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Material(
                            child: InkWell(
                              splashColor: Colors.tealAccent,
                              borderRadius: BorderRadius.circular(25),
                              onTap: () {},
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          Colors.teal.shade300,
                                          Colors.blue.shade700,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(Icons.check),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(ct.lista.itens[index].nome),
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
