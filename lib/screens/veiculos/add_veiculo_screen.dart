import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVeiculoScreen extends StatefulWidget {
  const AddVeiculoScreen({super.key});

  @override
  State<AddVeiculoScreen> createState() => _AddVeiculoScreenState();
}

class _AddVeiculoScreenState extends State<AddVeiculoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController placaController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController tipoCombustivelController = TextEditingController();
 
  bool loading = false;

  Future<void> salvarVeiculo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await FirebaseFirestore.instance.collection('veiculos').add({
        'placa': placaController.text.trim(),
        'marca': marcaController.text.trim(),
        'modelo': modeloController.text.trim(),
        "ano": anoController.text.trim(),
        "tipoCombustivel": tipoCombustivelController.text.trim(),
        'created_at': Timestamp.now(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Veículo cadastrado com sucesso!")),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Veículo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: placaController,
                decoration: const InputDecoration(
                  labelText: "Placa",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite a placa";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: marcaController,
                decoration: const InputDecoration(
                  labelText: "Marca",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite a marca";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: modeloController,
                decoration: const InputDecoration(
                  labelText: "Modelo",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite o modelo";
                  return null;
                },
              ),
              const SizedBox(height: 16),

               TextFormField(
                controller: anoController,
                decoration: const InputDecoration(
                  labelText: "Ano",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite o ano";
                  return null;
                },
              ),
              const SizedBox(height: 16),

               TextFormField(
                controller: tipoCombustivelController,
                decoration: const InputDecoration(
                  labelText: "Tipo de Combustivel",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Digite o tipo de combustivel";
                  return null;
                },
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : salvarVeiculo,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text("Salvar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
