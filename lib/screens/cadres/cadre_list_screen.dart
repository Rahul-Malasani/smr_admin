import 'package:flutter/material.dart';
import 'package:smr_admin/services/cadre_service.dart';
import 'package:smr_admin/models/cadre.dart';

class CadreListScreen extends StatelessWidget {
  const CadreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Cadre> cadres = CadreService.getCadres();

    return Scaffold(
      appBar: AppBar(title: const Text("Cadres")),
      body: ListView.builder(
        itemCount: cadres.length,
        itemBuilder: (context, index) {
          final cadre = cadres[index];
          return ListTile(
            title: Text(cadre.name),
            subtitle: Text("Created: ${cadre.createdDate}"),
          );
        },
      ),
    );
  }
}
