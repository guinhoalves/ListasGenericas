import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/listas_controller.dart';
import 'package:listas_genericas/widgets/button_sheet.dart';
import 'package:listas_genericas/widgets/show_confirm_dialog_widget.dart';

class ListasScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ListasController(),
      builder: (ListasController ct) {
        return WillPopScope(
          onWillPop: () async {
            showConfirme(
              context: context,
              label: "Deseja fechar o app?",
              confirme: () => SystemNavigator.pop(),
              cancel: () => Get.back(),
            );
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: Visibility(
                visible: ct.listasSelecionadas.length > 0,
                child: InkWell(
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  onLongPress: () {},
                  onTap: () => ct.cancelSelectListas(),
                ),
              ),
              title: ct.listasSelecionadas.length > 0
                  ? Text("${ct.listasSelecionadas.length} Iten(s) Selecionado(s)")
                  : Text("LIST IT"),
              actions: [
                Visibility(
                  visible: ct.listasSelecionadas.length == 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        ct.nmLista.text = ct.listasSelecionadas[0].titulo;
                        Get.bottomSheet(
                          ButtonSheetWidget(
                            nmLista: ct.nmLista,
                            onPressed: () {
                              ct.updateLista(ct.nmLista.text);
                              ct.nmLista.clear();
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
                  visible: ct.listasSelecionadas.length > 0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => ct.confirmaDeleteListas(ct.listasSelecionadas),
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
                    colors: <Color>[
                      Colors.teal.shade300,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: ct.listasSelecionadas.length > 0
                  ? null
                  : () => Get.bottomSheet(
                        ButtonSheetWidget(
                          nmLista: ct.nmLista,
                          onPressed: () {
                            ct.addLista(ct.nmLista.text);
                            ct.nmLista.clear();
                          },
                        ),
                        barrierColor: Colors.transparent,
                        enterBottomSheetDuration: Duration(milliseconds: 500),
                        exitBottomSheetDuration: Duration(milliseconds: 500),
                      ),
            ),
            body: Container(
              color: Colors.blueGrey.shade600,
              child: ListView.builder(
                itemCount: ct.listas.length,
                itemBuilder: (context, index) {
                  final int count = ct.listas.length > 10 ? 10 : ct.listas.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: ct.animationController,
                      curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  ct.animationController.forward();
                  return AnimatedBuilder(
                    animation: ct.animationController,
                    builder: (BuildContext context, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: Transform(
                          transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                                ct.listasBox,
                                              ],
                                            ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(10.0),
                                      title: Text(
                                        ct.listas[index].titulo.toUpperCase(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      subtitle: ct.listas[index].itens.length > 0
                                          ? Obx(() => Text(
                                              'Você Possui ${ct.listas[index].itens.length} Itens Nesta Lista.'))
                                          : Text('Nenhum Item Nesta Lista.'),
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
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
