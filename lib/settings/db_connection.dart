import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "hotel.db");

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE habitaciones("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "numero TEXT NOT NULL, "
          "tipo TEXT NOT NULL, "
          "precio REAL NOT NULL, "
          "estado TEXT NOT NULL"
          ")",
        );

        await db.execute(
          "CREATE TABLE clientes("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nombre TEXT NOT NULL, "
          "telefono TEXT NOT NULL, "
          "correo TEXT NOT NULL, "
          "documento TEXT NOT NULL"
          ")",
        );

        await db.execute(
          "CREATE TABLE reservas("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "cliente_id INTEGER NOT NULL, "
          "habitacion_id INTEGER NOT NULL, "
          "fecha_inicio TEXT NOT NULL, "
          "fecha_fin TEXT NOT NULL, "
          "FOREIGN KEY(cliente_id) REFERENCES clientes(id) ON DELETE CASCADE, "
          "FOREIGN KEY(habitacion_id) REFERENCES habitaciones(id) ON DELETE CASCADE"
          ")",
        );

        await db.execute(
          "CREATE TABLE pagos("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "reserva_id INTEGER NOT NULL, "
          "metodo_pago TEXT NOT NULL, "
          "monto REAL NOT NULL, "
          "fecha TEXT NOT NULL, "
          "FOREIGN KEY(reserva_id) REFERENCES reservas(id) ON DELETE CASCADE"
          ")",
        );
      },
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values,
    int id,
  ) async {
    final db = await database;
    return await db.update(
      table,
      values,
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;
    return await db.query(table);
  }
}
