import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/listas_controller.dart';
import 'package:listas_genericas/widgets/button_sheet.dart';

class ListasScreen extends GetView {
  final ct = Get.put(ListasController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ct,
      builder: (ListasController controller) {
        return Scaffold(
          appBar: AppBar(
            title: ct.listasSelecionadas.length > 0
                ? Text("${ct.listasSelecionadas.length} Iten(s) Selecionado(s)")
                : Text("MINHAS LISTAS"),
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
          floatingActionButton: FloatingActionButton(
            splashColor: Colors.blue.shade600,
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: ct.listasSelecionadas.length > 0
                      ? <Color>[
                          Colors.redAccent,
                          Colors.red.shade700,
                        ]
                      : <Color>[
                          Colors.teal.shade300,
                          Colors.blue.shade700,
                        ],
                ),
              ),
              child: Center(
                child: Icon(
                  ct.listasSelecionadas.length > 0 ? Icons.delete : Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: ct.listasSelecionadas.length > 0
                ? () => ct.confirmaDeleteListas(ct.listasSelecionadas)
                : () => Get.bottomSheet(
                      ButtonSheetWidget(
                        nmLista: ct.nmLista,
                        onPressed: () {
                          ct.addLista(ct.nmLista.text);
                          ct.nmLista.clear();
                        },
                      ),
                      barrierColor: Colors.transparent,
                    ),
          ),
          body: Container(
            color: Colors.blueGrey.shade600,
            child: ListView.builder(
              itemCount: ct.listas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: Colors.blue.shade600,
                          onLongPress: () => ct.toggleSelection(ct.listas[index]),
                          onTap: ct.listasSelecionadas.length > 0
                              ? () => ct.toggleSelection(ct.listas[index])
                              : () => Get.toNamed(
                                    '/detalhesLista',
                                    arguments: [
                                      ct.listas[index],
                                    ],
                                  ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            title: Text(
                              ct.listas[index].titulo.toUpperCase(),
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text('breve descrição da lista'),
                            trailing: Icon(
                              Icons.touch_app_outlined,
                              color: Colors.white,
                              size: 36,
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
                          colors: ct.listas[index].selecionado
                              ? <Color>[
                                  Colors.redAccent,
                                  Colors.red.shade700,
                                ]
                              : <Color>[
                                  Colors.teal.shade300,
                                  Colors.blue.shade700,
                                ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
