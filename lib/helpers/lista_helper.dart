import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String listaTable = "listaTable";

final String idColumn = "idColumn";
final String titleColumn = "titleColumn";
final String statusColumn = "statusColumn"; // 0 = ativo -- 1 = inativo
final String imgColumn = "imgColumn";
//-------------------------------------------------
final String itemListaTable = "itemListaTable";
final String idListaPaiColumn = "idListaPaiColumn";
final String nomeColumn = "nomeColumn";

class ListaHelper {
  static final ListaHelper _instance = ListaHelper.internal();

  factory ListaHelper() => _instance;

  ListaHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "listaNew.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $listaTable($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $statusColumn INTEGER DEFAULT 0, $imgColumn TEXT) ");
      await db.execute(
          "CREATE TABLE $itemListaTable($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nomeColumn TEXT, $statusColumn INTEGER DEFAULT 0, $idListaPaiColumn INTEGER)");
    });
  }

  Future<Lista> saveLista(Lista lista) async {
    Database dbLista = await db;
    lista.id = await dbLista.insert(listaTable, lista.toMap());
    return lista;
  }

  Future<ItemLista> saveItenLista(ItemLista itemLista) async {
    Database dbLista = await db;
    itemLista.id = await dbLista.insert(itemListaTable, itemLista.toMap());
    return itemLista;
  }

  Future<Lista> getLista(int id) async {
    Database dbLista = await db;
    List<Map> maps = await dbLista.query(listaTable,
        columns: [idColumn, titleColumn, statusColumn, imgColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Lista.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteLista(int id) async {
    Database dbLista = await db;
    return await dbLista
        .delete(listaTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteItemLista(int id) async {
    Database dbLista = await db;
    return await dbLista
        .delete(itemListaTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateLista(Lista lista) async {
    Database dbLista = await db;
    return await dbLista.update(listaTable, lista.toMap(),
        where: "$idColumn = ?", whereArgs: [lista.id]);
  }

  Future<int> updateitemLista(ItemLista itemlista) async {
    Database dbLista = await db;
    return await dbLista.update(itemListaTable, itemlista.toMap(),
        where: "$idColumn = ?", whereArgs: [itemlista.id]);
  }

  Future<List> getAllListas() async {
    Database dbLista = await db;
    List listMap = await dbLista.rawQuery("SELECT * FROM $listaTable");
    List<Lista> listLista = List();
    for (Map m in listMap) {
      listLista.add(Lista.fromMap(m));
    }
    return listLista;
  }

  Future<List> getAllItensLista(int idListaPai) async {
    List<ItemLista> listLista = List();
    Database dbLista = await db;
    List listMap = await dbLista.rawQuery(
        "SELECT * FROM $itemListaTable WHERE $idListaPaiColumn = $idListaPai");
    if (listMap == null) {
      return listLista;
    }

    for (Map m in listMap) {
      listLista.add(ItemLista.fromMap(m));
    }
    return listLista;
  }

  Future<int> getNumber() async {
    Database dbLista = await db;
    return Sqflite.firstIntValue(
        await dbLista.rawQuery("SELECT COUNT(*) FROM $listaTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Lista {
  int id;
  String title;
  int status;
  String img;

  Lista();

  Lista.fromMap(Map map) {
    id = map[idColumn];
    title = map[titleColumn];
    status = map[statusColumn];
    img = map[imgColumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      titleColumn: title,
      statusColumn: status,
      imgColumn: img
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Lista(id: $id,title:$title,status:$status,img:$img)";
  }
}

class ItemLista {
  int id;
  String nome;
  int status;
  int idListaPai;
  ItemLista();

  ItemLista.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    status = map[statusColumn];
    idListaPai = map[idListaPaiColumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      nomeColumn: nome,
      statusColumn: status,
      idListaPaiColumn: idListaPai,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "ItemLista(id: $id,nome:$nome,status:$status,idListaPai:$idListaPai)";
  }
}
