import 'package:flutter/material.dart';

import '../../entities/cliente_model.dart';
import '../../repositories/cliente_repository.dart';

class ClienteFormScreen extends StatefulWidget {
  final ClienteModel? cliente;

  ClienteFormScreen({
    super.key,
    this.cliente,
  });

  @override
  State<ClienteFormScreen> createState() {
    return _ClienteFormScreenState();
  }
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final documentoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.cliente != null) {
      nombreController.text = widget.cliente!.nombre;
      telefonoController.text = widget.cliente!.telefono;
      correoController.text = widget.cliente!.correo;
      documentoController.text = widget.cliente!.documento;
    }
  }

  Future<void> guardar() async {
    if (nombreController.text.isEmpty ||
        telefonoController.text.isEmpty ||
        correoController.text.isEmpty ||
        documentoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Complete todos los campos")),
      );
      return;
    }

    ClienteModel cliente = ClienteModel(
      nombre: nombreController.text,
      telefono: telefonoController.text,
      correo: correoController.text,
      documento: documentoController.text,
    );

    final clienteRepository = ClienteRepository();

    if (widget.cliente == null) {
      await clienteRepository.insert(cliente);
    } else {
      cliente.id = widget.cliente!.id;
      await clienteRepository.update(cliente);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.cliente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar cliente" : "Nuevo cliente"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: telefonoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Teléfono"),
            ),
            TextField(
              controller: correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Correo"),
            ),
            TextField(
              controller: documentoController,
              decoration: InputDecoration(labelText: "Documento"),
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
