import 'package:flutter/material.dart';

import '../../entities/reserva_model.dart';
import '../../repositories/reserva_repository.dart';

class ReservaListaScreen extends StatefulWidget {
  @override
  State<ReservaListaScreen> createState() {
    return _ReservaListaScreenState();
  }
}

class _ReservaListaScreenState extends State<ReservaListaScreen> {
  final repo = ReservaRepository();
  List<ReservaModel> reservas = [];

  @override
  void initState() {
    super.initState();
    cargarReservas();
  }

  Future<void> cargarReservas() async {
    reservas = await repo.getAll();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> eliminarReserva(ReservaModel reserva) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Desea eliminar la reserva ${reserva.id}?"),
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
      await repo.delete(reserva.id!);
      await cargarReservas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de reservas"),
      ),
      body: reservas.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                final reserva = reservas[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(reserva.id.toString()),
                    ),
                    title: Text("Reserva ${reserva.id}"),
                    subtitle: Text(
                      "Cliente: ${reserva.clienteId}\n"
                      "Habitación: ${reserva.habitacionId}\n"
                      "Inicio: ${reserva.fechaInicio}\n"
                      "Fin: ${reserva.fechaFin}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              "/reserva/form",
                              arguments: reserva,
                            );
                            cargarReservas();
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            eliminarReserva(reserva);
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
          await Navigator.pushNamed(context, "/reserva/form");
          cargarReservas();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
