import 'package:flutter/material.dart';

import '../../entities/habitacion_model.dart';
import '../../repositories/habitacion_repository.dart';

class HabitacionFormScreen extends StatefulWidget {
  final HabitacionModel? habitacion;

  HabitacionFormScreen({
    super.key,
    this.habitacion,
  });

  @override
  State<HabitacionFormScreen> createState() {
    return _HabitacionFormScreenState();
  }
}

class _HabitacionFormScreenState extends State<HabitacionFormScreen> {
  final numeroController = TextEditingController();
  final tipoController = TextEditingController();
  final precioController = TextEditingController();
  final estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.habitacion != null) {
      numeroController.text = widget.habitacion!.numero;
      tipoController.text = widget.habitacion!.tipo;
      precioController.text = widget.habitacion!.precio.toString();
      estadoController.text = widget.habitacion!.estado;
    }
  }

  Future<void> guardar() async {
    if (numeroController.text.isEmpty ||
        tipoController.text.isEmpty ||
        precioController.text.isEmpty ||
        estadoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Complete todos los campos")),
      );
      return;
    }

    HabitacionModel habitacion = HabitacionModel(
      numero: numeroController.text,
      tipo: tipoController.text,
      precio: double.tryParse(precioController.text) ?? 0,
      estado: estadoController.text,
    );

    final habitacionRepository = HabitacionRepository();

    if (widget.habitacion == null) {
      await habitacionRepository.insert(habitacion);
    } else {
      habitacion.id = widget.habitacion!.id;
      await habitacionRepository.update(habitacion);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.habitacion != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar habitación" : "Nueva habitación"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: numeroController,
              decoration: InputDecoration(labelText: "Número"),
            ),
            TextField(
              controller: tipoController,
              decoration: InputDecoration(labelText: "Tipo"),
            ),
            TextField(
              controller: precioController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Precio"),
            ),
            TextField(
              controller: estadoController,
              decoration: InputDecoration(labelText: "Estado"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardar,
              child: Text(esEdicion ? "Actualizar" : "Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
