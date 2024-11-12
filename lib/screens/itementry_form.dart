import 'package:flutter/material.dart';


class ItemEntryFormPage extends StatefulWidget {
  const ItemEntryFormPage({super.key});

  @override
  State<ItemEntryFormPage> createState() => _ItemEntryFormPageState();
}

class _ItemEntryFormPageState extends State<ItemEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
	String _itemType = "";
	String _itemName = "";
	int _itemPrice = 0;
  String _itemDescription = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Mau Tambah Produk Apa?',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Tipe Produk",
                      labelText: "Tipe Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _itemType = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Tipe produk tidak boleh kosong!";
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return "Tipe produk harus berisi kata-kata, tidak boleh hanya angka!";
                      }
                      if (value.trim().split(' ').where((word) => word.isNotEmpty).length < 1) {
                        return "Tipe produk harus ada minimal 1 kata!";
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Nama Produk",
                      labelText: "Nama Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _itemName = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama produk tidak boleh kosong!";
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return "Nama produk harus berisi kata-kata, tidak boleh hanya angka!";
                      }
                      if (value.trim().split(' ').where((word) => word.isNotEmpty).length < 2) {
                        return "Nama produk harus ada minimal 2 kata!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Harga",
                      labelText: "Harga",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _itemPrice = int.tryParse(value!) ?? 0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Harga tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Harga harus berupa angka!";
                      }
                      if (int.parse(value) < 0) {
                        return "Harga tidak boleh negatif!";
                      }
                      if (int.parse(value) == 0) {
                        return "Harga tidak boleh nol!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Deskripsi Produk",
                      labelText: "Deskripsi Produk",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _itemDescription = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi produk tidak boleh kosong!";
                      }
                      if (value.trim().split(' ').where((word) => word.isNotEmpty).length < 5) {
                        return "Deskripsi produk harus ada minimal 5 kata!";
                      }
                      if (!value.contains(RegExp(r'[a-zA-Z]'))) {
                        return "Deskripsi produk harus berisi kata-kata, tidak boleh hanya angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tipe Produk: $_itemType'),
                                    Text('Nama Produk: $_itemName'),
                                    Text('Harga Produk: $_itemPrice'),
                                    Text('Deskripsi Produk: $_itemDescription'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      );
  }
}