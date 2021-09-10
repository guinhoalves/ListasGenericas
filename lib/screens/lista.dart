// import 'package:flutter/material.dart';
// import 'package:fluttertoastalert/FlutterToastAlert.dart';
// import 'package:get/get.dart';
// import 'package:listas_genericas/helpers/lista_helper.dart';

// class ItemListaPage extends StatefulWidget {
//   final int idLista;
//   final String nomeLista;
//   ItemListaPage({required this.idLista, required this.nomeLista});

//   @override
//   _ItemListaPageState createState() => _ItemListaPageState();
// }

// class _ItemListaPageState extends State<ItemListaPage> {
//   final _nomeItemController = TextEditingController();

//   ListaHelper helper = ListaHelper();
//   List<ItemLista> itenslista = [];

//   // Map<String, dynamic> _listaItens;

//   late Map _lastRemoved;
//   late int _lastRemovedPos;

//   @override
//   void initState() {
//     super.initState();
//     _getAllItensLista();
//   }

//   _getAllItensLista() {
//     helper.getAllItensLista(widget.idLista).then(
//       (list) {
//         setState(
//           () {
//             itenslista = list;
//           },
//         );
//       },
//     );
//   }

//   _addItem(ItemLista itemLista) {
//     if (_nomeItemController.text != "") {
//       helper.saveItenLista(itemLista);
//       _nomeItemController.text = "";
//       _getAllItensLista();
//     } else {
//       FlutterToastAlert.showToastAndAlert(
//           type: Type.Warning,
//           androidToast: 'Escolha um nome para a tarefa!',
//           toastDuration: 5,
//           toastShowIcon: false);
//     }
//   }

//   Future<void> _refresh() async {
//     await Future.delayed(Duration(seconds: 1));
//     return helper.getAllItensLista(widget.idLista).then((list) {
//       setState(() {
//         itenslista = list;
//         itenslista.sort((a, b) {
//           if (a.status == 0 && b.status != 0)
//             return 1;
//           else if (a.status != 0 && b.status == 0)
//             return -1;
//           else
//             return 0;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ItemLista newItemLista = ItemLista();
//     return Container(
//       decoration: new BoxDecoration(
//         image: new DecorationImage(
//           image: new AssetImage("images/background-folha-com-pauta.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text(widget.nomeLista),
//           backgroundColor: Colors.blueGrey.shade900,
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.fromLTRB(17.0, 17.0, 7.0, 1.0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       cursorColor: Colors.black,
//                       controller: _nomeItemController,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.blueGrey.shade900, width: 2.0),
//                         ),
//                         labelText: "Nome do Item",
//                         labelStyle: TextStyle(color: Colors.blueGrey.shade900),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   FlatButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(50),
//                       ),
//                       color: Colors.blueGrey.shade900,
//                       child: Text("ADD"),
//                       textColor: Colors.white,
//                       onPressed: () {
//                         newItemLista.idListaPai = widget.idLista;
//                         newItemLista.nome = _nomeItemController.text;
//                         newItemLista.status = 0;
//                         _addItem(newItemLista);
//                       }),
//                   SizedBox(width: 10.0),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: _refresh,
//                 color: Colors.blueGrey.shade900,
//                 child: ListView.builder(
//                     padding: EdgeInsets.only(top: 10.0),
//                     itemCount: itenslista.length,
//                     itemBuilder: buildItem),
//               ),
//               // )
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildItem(BuildContext context, int index) {
//     return InkWell(
//       splashColor: Colors.blueGrey.shade600,
//       onLongPress: () => showDialogEditItem(context, index),
//       child: Dismissible(
//         background: Container(
//           color: Colors.redAccent,
//           child: Align(
//             alignment: Alignment(-0.9, 0.0),
//             child: Icon(Icons.delete, color: Colors.white),
//           ),
//         ),
//         direction: DismissDirection.startToEnd,
//         key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
//         child: CheckboxListTile(
//           activeColor: Colors.blueGrey.shade900,
//           checkColor: Colors.white,
//           title: Text(itenslista[index].nome),
//           value: itenslista[index].status == 0 ? false : true,
//           secondary: CircleAvatar(
//             backgroundColor: Colors.blueGrey.shade900,
//             child: Icon(
//               itenslista[index].status == 1 ? Icons.check : Icons.error,
//               color: Colors.white,
//             ),
//           ),
//           onChanged: (c) {
//             setState(() {
//               c == true ? itenslista[index].status = 1 : itenslista[index].status = 0;
//             });
//             helper.updateitemLista(itenslista[index]);
//           },
//         ),
//         onDismissed: (direcao) {
//           setState(() {
//             _lastRemoved = Map.from(itenslista[index].toMap());
//             _lastRemovedPos = index;
//             itenslista.removeAt(index);
//             helper.deleteItemLista(_lastRemoved["idColumn"]);
//             // _saveData();

//             final snack = SnackBar(
//               content: Text("Item \"${_lastRemoved["nomeColumn"]}\" removido!"),
//               action: SnackBarAction(
//                 label: "Desfazer",
//                 onPressed: () {
//                   setState(() {
//                     itenslista.insert(_lastRemovedPos, ItemLista.fromMap(_lastRemoved));
//                     helper.saveItenLista(ItemLista.fromMap(_lastRemoved));
//                     // _saveData();
//                   });
//                 },
//               ),
//               duration: Duration(seconds: 4),
//             );
//             Scaffold.of(context).removeCurrentSnackBar();
//             Scaffold.of(context).showSnackBar(snack);
//           });
//         },
//       ),
//     );
//   }

//   showDialogEditItem(BuildContext context, int index) {
//     TextEditingController _updatedNomeItemLista = TextEditingController(text: itenslista[index].nome);

//     AlertDialog simpleDialog = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       content: Container(
//         height: 150.0,
//         padding: EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(top: 35.0),
//                 child: TextField(
//                   cursorColor: Colors.blueGrey.shade900,
//                   controller: _updatedNomeItemLista,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.blueGrey.shade900, width: 2.0),
//                     ),
//                     labelText: "Novo Nome:",
//                     labelStyle: TextStyle(color: Colors.blueGrey.shade900),
//                   ),
//                   onChanged: (a) {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           children: <Widget>[
//             SizedBox(width: 10.0),
//             RaisedButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(5),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'CANCELAR',
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             SizedBox(width: 10.0),
//             FlatButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(5),
//               ),
//               color: Colors.green,
//               child: Row(
//                 children: <Widget>[
//                   Text(
//                     'SALVAR',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 setState(() {
//                   itenslista[index].nome = _updatedNomeItemLista.text;
//                   helper.updateitemLista(itenslista[index]).then((value) {});
//                   Navigator.of(context).pop();
//                 });
//               },
//             ),
//             SizedBox(width: 10.0),
//           ],
//         ),
//       ],
//     );
//     showDialog(context: context, builder: (BuildContext context) => simpleDialog);
//   }

// // Future<File> _getFile() async {
// //   final directory = await getApplicationDocumentsDirectory();
// //   return File("${directory.path}/data.json");
// // }

// // Future<File> _saveData() async {
// //   String data = json.encode(_listaItens);
// //   final file = await _getFile();
// //   return file.writeAsString(data);
// // }

// // Future<String> _readData() async {
// //   try {
// //     final file = await _getFile();
// //     return file.readAsString();
// //   } catch (e) {
// //     return null;
// //   }
// // }
// }
