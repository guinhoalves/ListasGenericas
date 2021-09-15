class ItemListaModel {
  String nome;
  String tipo;
  bool selecionado;

  ItemListaModel({
    required this.nome,
    required this.tipo,
    this.selecionado = false,
  });

  ItemListaModel.fromJson(dynamic json)
      : nome = json['nome'],
        tipo = json['tipo'],
        selecionado = json['selecionado'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nome'] = nome;
    data['tipo'] = tipo;
    data['selecionado'] = selecionado;

    return data;
  }
}
