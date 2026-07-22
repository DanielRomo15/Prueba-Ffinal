import 'package:flutter/material.dart';

import '../../entities/reserva_model.dart';
import '../../repositories/reserva_repository.dart';

class ReservaListaScreen extends StatefulWidget {
  const ReservaListaScreen({super.key});

  @override
  State<ReservaListaScreen> createState() =>
      _ReservaListaScreenState();
}

class _ReservaListaScreenState
    extends State<ReservaListaScreen> {
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

  Future<void> eliminarReserva(
    ReservaModel reserva,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirmar eliminación",
          ),
          content: Text(
            "¿Desea realmente eliminar la reserva ${reserva.id}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Aceptar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await repo.delete(reserva.id!);

      await cargarReservas();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "La reserva ${reserva.id} ha sido eliminada",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de reservas",
        ),
      ),
      body: reservas.isEmpty
          ? const Center(
              child: Text(
                "No existen datos",
              ),
            )
          : ListView.builder(
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                final reserva = reservas[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        reserva.id.toString(),
                      ),
                    ),
                    title: Text(
                      "Reserva número ${reserva.id}",
                    ),
                    subtitle: Text(
                      "Cliente: ${reserva.clienteId}\n"
                      "Habitación: ${reserva.habitacionId}\n"
                      "Inicio: ${reserva.fechaInicio}\n"
                      "Fin: ${reserva.fechaFin}",
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,
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
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            eliminarReserva(reserva);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            "/reserva/form",
          );

          cargarReservas();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}