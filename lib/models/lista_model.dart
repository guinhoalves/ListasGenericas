import 'item_lista_model.dart';

class ListaModel {
  String titulo;
  int? status;
  bool selecionado;
  List<ItemListaModel>? itens = [];

  ListaModel({
    required this.titulo,
    this.status,
    this.selecionado = false,
    this.itens,
  });

  ListaModel.fromJson(dynamic json)
      : titulo = json['titulo'],
        status = json['status'],
        selecionado = json['selecionado'],
        itens = List<ItemListaModel>.from(json["itens"].map((x) => ItemListaModel.fromJson(x)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['titulo'] = titulo;
    data['status'] = status;
    data['selecionado'] = selecionado;
    data['itens'] = itens;
    return data;
  }
}
