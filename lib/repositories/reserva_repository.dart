import '../entities/reserva_model.dart';
import '../settings/db_connection.dart';

class ReservaRepository {
  final String tableName = "reservas";

  // INSTANCIAR LA CLASE PARA CONSUMIR LOS METODOS
  final DbConnection db = DbConnection();

  // INSERTAR
  Future<int> insert(ReservaModel data) async {
    return await db.insert(
      tableName,
      data.toMap(),
    );
  }

  // ACTUALIZAR
  Future<int> update(ReservaModel data) async {
    return await db.update(
      tableName,
      data.toMap(),
      data.id!,
    );
  }

  // ELIMINAR
  Future<int> delete(int id) async {
    return await db.delete(
      tableName,
      id,
    );
  }

  // CONSULTAR TODOS
  Future<List<ReservaModel>> getAll() async {
    final data = await db.getAll(tableName);

    return data
        .map((i) => ReservaModel.fromMap(i))
        .toList();
  }
}