import 'package:flutter/material.dart';
import 'package:pueba-ffinal-1/entities/habitacion_model.dart';
import '../../../repositories/habitacion_repository.dart';

class HabitacionFormScreen extends StatefulWidget {
  final HabitacionModel? habitacion;

  const HabitacionFormScreen({
    super.key,
    this.habitacion,
  });

  @override
  State<HabitacionFormScreen> createState() =>
      _HabitacionFormScreenState();
}

class _HabitacionFormScreenState
    extends State<HabitacionFormScreen> {
  final numeroController = TextEditingController();
  final tipoController = TextEditingController();
  final precioController = TextEditingController();
  final estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.habitacion != null) {
      numeroController.text =
          widget.habitacion!.numero;

      tipoController.text =
          widget.habitacion!.tipo;

      precioController.text =
          widget.habitacion!.precio.toString();

      estadoController.text =
          widget.habitacion!.estado;
    }
  }

  Future<void> guardar() async {
    HabitacionModel habitacion = HabitacionModel(
      numero: numeroController.text,
      tipo: tipoController.text,
      precio: double.parse(precioController.text),
      estado: estadoController.text,
    );

    final habitacionRepository =
        HabitacionRepository();

    if (widget.habitacion == null) {
      await habitacionRepository.insert(habitacion);
    } else {
      habitacion.id = widget.habitacion!.id;

      await habitacionRepository.update(habitacion);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion =
        widget.habitacion != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion
              ? "Editar Habitación"
              : "Nueva Habitación",
        ),
      ),

      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: numeroController,

              decoration: const InputDecoration(
                labelText: "Número",
              ),
            ),

            TextFormField(
              controller: tipoController,

              decoration: const InputDecoration(
                labelText: "Tipo",
              ),
            ),

            TextFormField(
              controller: precioController,

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Precio",
              ),
            ),

            TextFormField(
              controller: estadoController,

              decoration: const InputDecoration(
                labelText: "Estado",
              ),
            ),

            ElevatedButton(
              onPressed: guardar,

              child: const Text(
                "Guardar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}