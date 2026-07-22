import '../entities/pago_model.dart';
import '../settings/db_connection.dart';

class PagoRepository {
  final String tableName = "pagos";

  // INSTANCIAR LA CLASE PARA CONSUMIR LOS METODOS
  final DbConnection db = DbConnection();

  // INSERTAR
  Future<int> insert(PagoModel data) async {
    return await db.insert(
      tableName,
      data.toMap(),
    );
  }

  // ACTUALIZAR
  Future<int> update(PagoModel data) async {
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
  Future<List<PagoModel>> getAll() async {
    final data = await db.getAll(tableName);

    return data
        .map((i) => PagoModel.fromMap(i))
        .toList();
  }
}