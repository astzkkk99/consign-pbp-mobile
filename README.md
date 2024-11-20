**Tugas 9** 
----------------
**Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.**

**Untuk masalah terkait PWS yang belum bisa diintegrasikan dengan Flutter, Tim Asdos akan menginformasikan secara menyusul. Untuk sementara, kalian diperbolehkan untuk melakukan integrasi pada local host saja.**


**Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.**
**Membuat halaman login pada proyek tugas Flutter.**
**Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.**
1. Buat app django bernama authentication
2. Install django-corsheaders
3. Buat method view untuk login pada authentication
4. lalu pada directory flutter, install package pub add provider, dan pub add pbp_django_auth
5. Modifikasi widget pada main.dart
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Mental Health Tracker',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(secondary: Colors.deepPurple[400]),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
```
6. Buat file baru pada screens bernama login.dart
7. Dan buat file register.dart juga


**Membuat model kustom sesuai dengan proyek aplikasi Django.**
1. Dengan quicktype, copy json dari proyek django, lalu masukan ke quicktype, lalu salin kodenya:
```
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    String model;
    String pk;
    Fields fields;

    Item({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String itemType;
    String itemName;
    int itemPrice;
    String itemDescription;

    Fields({
        required this.title,
        required this.itemType,
        required this.itemName,
        required this.itemPrice,
        required this.itemDescription,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        itemType: json["item_type"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        itemDescription: json["item_description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "item_type": itemType,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_description": itemDescription,
    };
}
```

**Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.**
**Tampilkan name, price, dan description dari masing-masing item pada halaman ini.**
1. download package http dengan flutter pub add http pada proyek flutter
2. buat list_itementry.dart pada lib/screens
```
import 'dart:convert';

import 'package:consign_pbp/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
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
                    onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                            // Kirim ke Django dan tunggu respons
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            final response = await request.postJson(
                                "http://127.0.0.1:8000/create-flutter/",
                                jsonEncode(<String, String>{
                                    // 'title': _title,
                                    'item_type': _itemType,
                                    'item_name': _itemName,
                                    'item_price': _itemPrice.toString(),
                                    'item_description': _itemDescription,
                                // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                }),
                            );
                            if (context.mounted) {
                                if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                    content: Text("Produk baru berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content:
                                            Text("Terdapat kesalahan, silakan coba lagi."),
                                    ));
                                }
                            }
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
```


**Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.**

**Halaman ini dapat diakses dengan menekan salah satu item pada halaman daftar Item.**

**Tampilkan seluruh atribut pada model item kamu pada halaman ini.**

**Tambahkan tombol untuk kembali ke halaman daftar item.**

**Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.**

-------


**Menjawab beberapa pertanyaan berikut pada README.md pada root folder (silakan modifikasi README.md yang telah kamu buat sebelumnya; tambahkan subjudul untuk setiap tugas).**

**Jelaskan mengapa kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON? Apakah akan terjadi error jika kita tidak membuat model terlebih dahulu?**
Mempermudah Parsing JSON:
Model membantu memetakan data JSON ke dalam objek Dart atau Python (di backend), sehingga lebih mudah diakses dengan properti atau metode yang relevan.

Contoh: JSON dari server yang berisi data item_name, item_price, dan item_description dapat diakses sebagai properti model Item.
Meningkatkan Keamanan:
Tanpa model, pengambilan data secara langsung dari JSON rentan terhadap kesalahan jika kunci JSON tidak sesuai atau struktur data berubah.

Mempermudah Debugging:
Dengan model, data JSON yang diterima bisa divalidasi sebelum digunakan, sehingga meminimalisasi error runtime.

Apakah Error Akan Terjadi Tanpa Model?
Tidak selalu terjadi error, tetapi:

Pengelolaan Data Jadi Sulit: Tanpa model, Anda harus memanipulasi data JSON sebagai map (key-value), yang tidak aman jika kunci atau struktur JSON berubah.
Kesalahan Parsing: Jika kunci JSON tidak ada atau ada typo, aplikasi dapat mengalami error NoSuchMethodError.

**Jelaskan fungsi dari library http yang sudah kamu implementasikan pada tugas ini**

Melakukan Request HTTP:
Library ini digunakan untuk mengirimkan request ke server Django, seperti:

GET: Mengambil data item dari server.
POST: Mengirim data registrasi atau login ke server.
Memproses Response dari Server:
Data yang diterima dari server (biasanya dalam format JSON) diproses oleh library ini agar dapat digunakan di Flutter.

Mengelola Header HTTP:
Library http memungkinkan pengaturan header (seperti Content-Type, Authorization) untuk komunikasi dengan server.

**Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.**


Mengelola Session:
CookieRequest menyimpan cookie session yang diterima dari Django setelah login. Cookie ini digunakan untuk menjaga sesi pengguna tetap aktif di aplikasi Flutter.

Menyertakan Cookie pada Setiap Request:
Instance CookieRequest secara otomatis menambahkan cookie session ke setiap request HTTP ke server Django, memastikan bahwa request diidentifikasi sebagai milik pengguna yang telah login.

Manajemen Autentikasi:

Login: Mengirimkan username dan password ke Django, menerima cookie session.
Logout: Menghapus session dari server dan Flutter.
Mengapa Instance CookieRequest Perlu Dibagikan ke Semua Komponen Flutter?
Karena instance ini berfungsi sebagai satu-satunya sumber untuk autentikasi pengguna. Dengan membagikannya:

Semua komponen Flutter dapat mengakses data session pengguna.
Tidak perlu membuat ulang instance CookieRequest, menjaga konsistensi autentikasi.

**Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.**

Langkah-Langkahnya:
1. Input Data di Flutter:
Pengguna mengisi form (contoh: form registrasi atau login).
Data input pengguna disimpan sementara di variabel Flutter.

2. Mengirim Data ke Django:
Data diubah menjadi JSON menggunakan jsonEncode.
Data dikirim ke Django menggunakan POST melalui library http atau CookieRequest.

3. Proses di Django:
Django menerima data dari Flutter melalui request body.
Django memvalidasi data, misalnya memeriksa format atau mengecek apakah data sudah ada di database.
Setelah validasi, Django menyimpan data di database (untuk registrasi) atau membandingkan data login dengan data di database.

4. Respon dari Django:
Django mengirimkan response JSON kembali ke Flutter (contoh: status sukses atau error).

5. Menampilkan Data di Flutter:
Data JSON dari server diubah menjadi objek model menggunakan fungsi fromJson.
Data ditampilkan di widget Flutter.


**Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.**

1. Register

Input Data di Flutter:

Pengguna mengisi form registrasi di Flutter.
Data (username, password, email) dikirim ke Django menggunakan request POST.

Proses di Django:

Django menerima data, memvalidasi, dan menyimpan pengguna baru di database menggunakan model User.
Respon ke Flutter:

Django mengirimkan status sukses atau error (misalnya jika username sudah digunakan).

2. Login

Input Data di Flutter:

Pengguna mengisi username dan password di form login.
Data dikirim ke Django menggunakan POST.

Proses di Django:

Django memeriksa username dan password di database.
Jika valid, Django membuat session baru dan mengirim cookie session ke Flutter.

Respon ke Flutter:

Flutter menerima cookie session dan menyimpannya di CookieRequest.
Menu utama aplikasi ditampilkan.

3. Logout

Proses di Flutter:
Flutter mengirim request POST ke endpoint logout di Django.

Proses di Django:
Django menghapus session pengguna.

Flutter Menghapus Data Session:
Flutter menghapus data session lokal, sehingga pengguna harus login kembali untuk mengakses fitur.