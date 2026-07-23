import 'package:flutter/material.dart';

import '../../entities/habitacion_model.dart';
import '../../repositories/habitacion_repository.dart';

class HabitacionListaScreen extends StatefulWidget {
  @override
  State<HabitacionListaScreen> createState() {
    return _HabitacionListaScreenState();
  }
}

class _HabitacionListaScreenState extends State<HabitacionListaScreen> {
  final repo = HabitacionRepository();
  List<HabitacionModel> habitaciones = [];

  @override
  void initState() {
    super.initState();
    cargarHabitaciones();
  }

  Future<void> cargarHabitaciones() async {
    habitaciones = await repo.getAll();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> eliminarHabitacion(HabitacionModel habitacion) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text(
            "¿Desea eliminar la habitación ${habitacion.numero}?",
          ),
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
      await repo.delete(habitacion.id!);
      await cargarHabitaciones();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de habitaciones"),
      ),
      body: habitaciones.isEmpty
          ? Center(child: Text("No existen datos"))
          : ListView.builder(
              itemCount: habitaciones.length,
              itemBuilder: (context, index) {
                final habitacion = habitaciones[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(habitacion.id.toString()),
                    ),
                    title: Text("Habitación ${habitacion.numero}"),
                    subtitle: Text(
                      "Tipo: ${habitacion.tipo}\n"
                      "Precio: \$${habitacion.precio.toStringAsFixed(2)}\n"
                      "Estado: ${habitacion.estado}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              "/habitacion/form",
                              arguments: habitacion,
                            );
                            cargarHabitaciones();
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            eliminarHabitacion(habitacion);
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
          await Navigator.pushNamed(context, "/habitacion/form");
          cargarHabitaciones();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
