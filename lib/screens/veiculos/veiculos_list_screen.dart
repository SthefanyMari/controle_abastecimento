import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/veiculo_provider.dart';
import 'add_veiculo_screen.dart'; 

class VeiculosListScreen extends StatelessWidget {
  const VeiculosListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VeiculoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Veículos"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddVeiculoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: provider.veiculos.isEmpty
          ? const Center(child: Text("Nenhum veículo cadastrado"))
          : ListView.builder(
              itemCount: provider.veiculos.length,
              itemBuilder: (_, i) {
                final v = provider.veiculos[i];
                return Card(
                  child: ListTile(
                    title: Text("${v.modelo} - ${v.marca}"),
                    subtitle: Text("${v.placa} • ${v.tipoCombustivel}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteVeiculo(v.id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
