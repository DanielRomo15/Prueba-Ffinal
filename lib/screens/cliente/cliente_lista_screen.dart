import 'package:flutter/material.dart';

import '../../entities/cliente_model.dart';
import '../../repositories/cliente_repository.dart';

class ClienteListaScreen extends StatefulWidget {
  @override
  State<ClienteListaScreen> createState() {
    return _ClienteListaScreenState();
  }
}

class _ClienteListaScreenState extends State<ClienteListaScreen> {
  final repo = ClienteRepository();
  List<ClienteModel> clientes = [];

  @override
  void initState() {
    super.initState();
    cargarClientes();
  }

  Future<void> cargarClientes() async {
    clientes = await repo.getAll();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> eliminarCliente(ClienteModel cliente) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Desea eliminar a ${cliente.nombre}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await repo.delete(cliente.id!);
      await cargarClientes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de clientes"),
      ),
      body: clientes.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(cliente.id.toString()),
                    ),
                    title: Text(cliente.nombre),
                    subtitle: Text(
                      "Teléfono: ${cliente.telefono}\n"
                      "Correo: ${cliente.correo}\n"
                      "Documento: ${cliente.documento}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              "/cliente/form",
                              arguments: cliente,
                            );
                            cargarClientes();
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            eliminarCliente(cliente);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/cliente/form");
          cargarClientes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
