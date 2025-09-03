import 'package:flutter/material.dart';
import 'package:smr_admin/services/cadre_service.dart';
import 'package:smr_admin/models/cadre.dart';
import 'package:intl/intl.dart';
import 'package:smr_admin/screens/cadres/cadre_form.dart'; 
import 'package:smr_admin/widgets/logout_widget.dart'; // ✅ Reusable logout

class CadreListScreen extends StatefulWidget {
  const CadreListScreen({super.key});

  @override
  State<CadreListScreen> createState() => _CadreListScreenState();
}

class _CadreListScreenState extends State<CadreListScreen> {
  List<Cadre> cadres = [];

  @override
  void initState() {
    super.initState();
    cadres = CadreService.getAll();
  }

  void _addCadre() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => CadreForm()),
    ).then((_) {
      setState(() {
        cadres = CadreService.getAll();
      });
    });
  }

  void _deleteCadre(Cadre cadre) {
    CadreService.delete(cadre.name);
    setState(() {
      cadres = CadreService.getAll();
    });
  }

  Future<void> _confirmDelete(BuildContext context, Function onConfirm) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this cadre?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
    if (shouldDelete == true) {
      onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadres"),
        actions: const [
          LogoutWidget(), // ✅ now using global widget
        ],
      ),
      body: ListView.builder(
        itemCount: cadres.length,
        itemBuilder: (context, index) {
          final cadre = cadres[index];
          return ListTile(
            title: Text(cadre.name),
            subtitle: Text(
              "Created: ${DateFormat('dd/MM/yyyy').format(cadre.createdDate)}",
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () =>
                  _confirmDelete(context, () => _deleteCadre(cadre)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCadre,
        child: const Icon(Icons.add),
      ),
    );
  }
}
