import 'item_lista_model.dart';

class ListaModel {
  int? id;
  String titulo;
  int? status;
  bool selecionado;
  List<ItemListaModel> itens;

  ListaModel({
    this.id,
    required this.titulo,
    this.status,
    this.selecionado = false,
    required this.itens,
  });

  ListaModel.fromJson(dynamic json)
      : titulo = json['titulo'],
        id = json['id'],
        status = json['status'],
        selecionado = json['selecionado'],
        itens = List.from(
          json["itens"].map(
            (x) => ItemListaModel.fromJson(x),
          ),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['titulo'] = titulo;
    data['status'] = status;
    data['selecionado'] = selecionado;
    data['itens'] = this.itens.map((v) => v.toJson()).toList();
    return data;
  }
}
