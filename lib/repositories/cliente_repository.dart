import '../entities/cliente_model.dart';
import '../settings/db_connection.dart';

class ClienteRepository {
  final String tableName = "clientes";
  final DbConnection db = DbConnection();

  Future<int> insert(ClienteModel data) async {
    return await db.insert(tableName, data.toMap());
  }

  Future<int> update(ClienteModel data) async {
    return await db.update(tableName, data.toMap(), data.id!);
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, id);
  }

  Future<List<ClienteModel>> getAll() async {
    final data = await db.getAll(tableName);
    return data.map((i) => ClienteModel.fromMap(i)).toList();
  }
}
