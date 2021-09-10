import 'package:get/get.dart';

import 'package:listas_genericas/models/lista_model.dart';

class DetalhesListaController extends GetxController {
  late ListaModel lista;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    if (Get.arguments != null) lista = Get.arguments[0];
    super.onInit();
  }
}
