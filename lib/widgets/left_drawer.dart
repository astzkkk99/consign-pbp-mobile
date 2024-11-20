import 'package:consign_pbp/screens/itementry_form.dart';
import 'package:consign_pbp/screens/list_itementry.dart';
import 'package:consign_pbp/screens/menu.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
                    decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              children: [
                Text(
                  'Consign!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Text(
                  "Consign! aja",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )
                ),
              ],
            ),
          ),
                    ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline_rounded),
            title: const Text('Tambah Produk'),
            // Bagian redirection ke ItemEntryFormPage
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemEntryFormPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('Daftar Item'),
            onTap: () {
                // Route menu ke halaman item
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ItemEntryPage()),
                );
            },
        ),
        ],
      ),
    );
  }
}