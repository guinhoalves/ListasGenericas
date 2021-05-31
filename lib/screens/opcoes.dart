import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/helpers/lista_helper.dart';

import 'pagina_inicial.dart';

class OpcoesPage extends StatefulWidget {
  final Lista lista;

  OpcoesPage({this.lista});
  @override
  _OpcoesPageState createState() => _OpcoesPageState();
}

class _OpcoesPageState extends State<OpcoesPage> {
  ListaHelper helper = ListaHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/background-folha-com-pauta.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.lista.title),
          backgroundColor: Colors.blueGrey.shade900,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(35.0),
          children: [
            _cardEditar(),
            SizedBox(
              height: 10.0,
            ),
            _cardExcluir(),
            SizedBox(
              height: 10.0,
            ),
            _cardCompartilhar()
          ],
        ),
      ),
    );
  }

  Widget _cardExcluir() {
    return InkWell(
      splashColor: Colors.red,
      child: Card(
        color: Colors.red.shade400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Text(
                "Excluir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                  size: 35.0,
                )),
          ],
        ),
      ),
      onTap: () {
        showDialogDelete(context);
      },
    );
  }

  Widget _cardEditar() {
    return InkWell(
      splashColor: Colors.green,
      child: Card(
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Text(
                "Editar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 35.0,
                )),
          ],
        ),
      ),
      onTap: () {
        showDialogUpdate(context);
      },
    );
  }

  Widget _cardCompartilhar() {
    return InkWell(
      splashColor: Colors.blue,
      child: Card(
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Text(
                "Compartilhar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 35.0,
                )),
          ],
        ),
      ),
      onTap: () {
        _showDialogCompartilhar();
      },
    );
  }

  showDialogUpdate(BuildContext context) {
    TextEditingController _updatedNomeLista =
        TextEditingController(text: widget.lista.title);

    AlertDialog simpleDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Container(
        height: 150.0,
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: TextField(
                  cursorColor: Colors.blueGrey.shade900,
                  controller: _updatedNomeLista,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.blueGrey.shade900, width: 2.0),
                    ),
                    labelText: "Novo Nome:",
                    labelStyle: TextStyle(color: Colors.blueGrey.shade900),
                  ),
                  onChanged: (a) {},
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10.0),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'CANCELAR',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(width: 10.0),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5),
              ),
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  Text(
                    'SALVAR',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  widget.lista.title = _updatedNomeLista.text;
                  helper.updateLista(widget.lista).then((value) {
                    Get.offAll(PaginaInicial());
                  });
                });
              },
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  showDialogDelete(BuildContext context) {
    AlertDialog simpleDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: Container(
        alignment: Alignment.center,
        height: 150.0,
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Tem certeza?",
                        style: TextStyle(
                            color: Colors.blueGrey.shade900, fontSize: 18.0),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10.0),
            Container(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'CANCELAR',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5),
              ),
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  Text(
                    'CONFIRMAR',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onPressed: () async {
                await helper
                    .getAllItensLista(widget.lista.id)
                    .then((list) async {
                  if (list != null || list.length > 0) {
                    for (var item in list) {
                      helper.deleteItemLista(item.id);
                    }
                    helper.deleteLista(widget.lista.id);
                  } else {
                    helper.deleteLista(widget.lista.id);
                  }
                });
                Get.offAll(PaginaInicial());
              },
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  Future<void> _showDialogCompartilhar() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opis!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Esta Funcionalidade ainda esta em fase de desenvolvimento!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
