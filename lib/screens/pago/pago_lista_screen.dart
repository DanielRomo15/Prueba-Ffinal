import 'package:flutter/material.dart';

import '../../entities/pago_model.dart';
import '../../repositories/pago_repository.dart';

class PagoListaScreen extends StatefulWidget {
  const PagoListaScreen({super.key});

  @override
  State<PagoListaScreen> createState() =>
      _PagoListaScreenState();
}

class _PagoListaScreenState
    extends State<PagoListaScreen> {
  final repo = PagoRepository();

  List<PagoModel> pagos = [];

  @override
  void initState() {
    super.initState();
    cargarPagos();
  }

  Future<void> cargarPagos() async {
    pagos = await repo.getAll();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> eliminarPago(
    PagoModel pago,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirmar eliminación",
          ),
          content: Text(
            "¿Desea realmente eliminar el pago ${pago.id}?",
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
      await repo.delete(pago.id!);

      await cargarPagos();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "El pago ${pago.id} ha sido eliminado",
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
          "Lista de pagos",
        ),
      ),
      body: pagos.isEmpty
          ? const Center(
              child: Text(
                "No existen datos",
              ),
            )
          : ListView.builder(
              itemCount: pagos.length,
              itemBuilder: (context, index) {
                final pago = pagos[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        pago.id.toString(),
                      ),
                    ),
                    title: Text(
                      "Pago número ${pago.id}",
                    ),
                    subtitle: Text(
                      "Reserva: ${pago.reservaId}\n"
                      "Método: ${pago.metodoPago}\n"
                      "Monto: \$${pago.monto.toStringAsFixed(2)}\n"
                      "Fecha: ${pago.fecha}",
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
                              "/pago/form",
                              arguments: pago,
                            );

                            cargarPagos();
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            eliminarPago(pago);
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
            "/pago/form",
          );

          cargarPagos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}