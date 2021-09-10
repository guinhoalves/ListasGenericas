class ListaModel {
  String titulo;
  int? status;
  bool selecionado;

  ListaModel({
    required this.titulo,
    this.status,
    this.selecionado = false,
  });

  ListaModel.fromJson(dynamic json)
      : titulo = json['titulo'],
        status = json['status'],
        selecionado = json['selecionado'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['titulo'] = titulo;
    data['status'] = status;
    data['selecionado'] = selecionado;

    return data;
  }
}
