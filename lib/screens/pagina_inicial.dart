import 'package:flutter/material.dart';
import 'package:fluttertoastalert/FlutterToastAlert.dart';
import 'package:listas_genericas/helpers/lista_helper.dart';

import 'lista.dart';
import 'opcoes.dart';

class PaginaInicial extends StatefulWidget {
  final Lista listageral;

  PaginaInicial({this.listageral});

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final _nomeListaController = TextEditingController();

  ListaHelper helper = ListaHelper();
  List<Lista> listas = List();

  @override
  void initState() {
    super.initState();
    _getAllListas();
  }

  _getAllListas() {
    helper.getAllListas().then((list) {
      setState(() {
        listas = list;
      });
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    return helper.getAllListas().then((list) {
      setState(() {
        listas = list;
      });
    });
  }

  _addToDo(Lista lista) {
    if (_nomeListaController.text != "") {
      helper.saveLista(lista);
      _getAllListas();
    } else {
      FlutterToastAlert.showToastAndAlert(
          type: Type.Warning,
          androidToast: 'Escolha um nome para a Lista!',
          toastDuration: 5,
          toastShowIcon: false);
    }
  }

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
          title: Text("Minhas Listas"),
          backgroundColor: Colors.blueGrey.shade900,
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                await showSimpleCustomDialog(context)
                    .whenComplete(() => _getAllListas());
              },
              child: Icon(Icons.add_circle_outline),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _refresh();
                  },
                  color: Colors.blueGrey.shade900,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0),
                      itemCount: listas.length,
                      itemBuilder: buildItem),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSimpleCustomDialog(BuildContext context) async {
    // TextEditingController nomeLista = TextEditingController();
    Lista newLista = Lista();
    AlertDialog simpleDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.transparent,
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
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: _nomeListaController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    labelText: "Nome da Lista",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (text) {
                    setState(() {
                      newLista.title = text;
                    });
                  },
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
                _nomeListaController.text = "";
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
              onPressed: () async {
                newLista.title = _nomeListaController.text;
                newLista.img = "";
                newLista.status = 0;
                print(newLista);
                await _addToDo(newLista);
                _nomeListaController.text = "";
                Navigator.of(context).pop();
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

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      splashColor: Colors.blueGrey.shade600,
      onLongPress: () async {
        _navigatorOpcoes(context, index);
      },
      onTap: () {
        print(listas[index]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemListaPage(
              idLista: listas[index].id,
              nomeLista: listas[index].title,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade900, width: 2.0),
            //border: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(
                  listas[index].title,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Container(
                width: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.blueGrey.shade900,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _navigatorOpcoes(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpcoesPage(
          lista: listas[index],
        ),
      ),
    );
  }
}
