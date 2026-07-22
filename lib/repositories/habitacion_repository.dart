import 'package:prueba-ffinal-1/entities/habitacion.dart';
import 'package:prueba-ffinal-1/repositories/db_connection.dart';

class HabitacionRepository {
  final String tableName = "habitaciones";
  final DBConnection db = DBConnection();

  Future<int> insert(HabitacionModel data) async {
    return await db.insert(tableName, data.toMap());
  }

  Future<int> update(HabitacionModel data) async {
    return await db.update(tableName, data.toMap(), data.id!);
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, id);
  }

  Future<List<HabitacionModel>> getAll() async {
    final data = await db.getAll(tableName);

    return data.map((i) => HabitacionModel.fromMap(i)).toList();
  }
}