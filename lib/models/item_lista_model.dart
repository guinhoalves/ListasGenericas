class ItemListaModel {
  int? id;
  String nome;
  String tipo;
  bool selecionado;
  bool feito;

  ItemListaModel({
    this.id,
    required this.nome,
    required this.tipo,
    this.selecionado = false,
    this.feito = false,
  });

  ItemListaModel.fromJson(dynamic json)
      : id = json['id'],
        nome = json['nome'],
        tipo = json['tipo'],
        selecionado = json['selecionado'],
        feito = json['feito'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['tipo'] = tipo;
    data['selecionado'] = selecionado;
    data['feito'] = feito;

    return data;
  }
}
