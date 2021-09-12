import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/controllers/detalhes_lista_controller.dart';
import 'package:listas_genericas/widgets/botao_circular_widget.dart';

class DetalhesListaScreen extends GetView {
  final ct = Get.put(DetalhesListaController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ct,
      builder: (DetalhesListaController controller) {
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
            child: Stack(
              children: [
                Positioned(
                  right: 30,
                  bottom: 30,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset.fromDirection(
                          ct.getRadiansFromDegree(270),
                          ct.degOneTranslationAnimation.value * 100,
                        ),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                            ct.getRadiansFromDegree(ct.rotationAnimation.value),
                          )..scale(ct.degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 50,
                            height: 50,
                            color: Colors.blue,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(
                          ct.getRadiansFromDegree(225),
                          ct.degTwoTranslationAnimation.value * 100,
                        ),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                            ct.getRadiansFromDegree(ct.rotationAnimation.value),
                          )..scale(ct.degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 50,
                            height: 50,
                            color: Colors.black,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(
                            ct.getRadiansFromDegree(180), ct.degThreeTranslationAnimation.value * 100),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                            ct.getRadiansFromDegree(ct.rotationAnimation.value),
                          )..scale(ct.degThreeTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                            width: 50,
                            height: 50,
                            color: Colors.orangeAccent,
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            onClick: () {},
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(
                          ct.getRadiansFromDegree(ct.rotationAnimation.value),
                        ),
                        alignment: Alignment.center,
                        child: CircularButton(
                          width: 60,
                          height: 60,
                          color: Colors.red,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onClick: () => ct.mostraOpcoes(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
