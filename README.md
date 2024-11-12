**Tugas 8** 
----------------
**Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru dengan ketentuan sebagai berikut:**

**Memakai minimal tiga elemen input, yaitu name, amount, description. Tambahkan elemen input sesuai dengan model pada aplikasi tugas Django yang telah kamu buat.**
1. Buat file baru pada direktori lib, saya namakan itementry_form.dart
2. Buat elemen input sesuai dengan models, :
```
class _ItemEntryFormPageState extends State<ItemEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
	String _itemType = "";
	String _itemName = "";
	int _itemPrice = 0;
  String _itemDescription = "";

}
```

Dalam tugas saya menggunakan model itemType, itemName, itemPrice, itemDescription

**Memiliki sebuah tombol Save.**
```
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
```

**Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:**

**Setiap elemen input tidak boleh kosong.**

**Setiap elemen input harus berisi data dengan tipe data atribut modelnya.**


itemType
```
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

```


itemName
```
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
```

itemPrice
```
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
```
itemDescription
```
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
```

**Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.**

Pada MyHomePage, ketika pengguna menekan tombol Tambah Produk, mereka diarahkan ke halaman ItemEntryFormPage:
```
if (item.name == "Tambah Produk") {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ItemEntryFormPage()),
  );
}
```


**Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru.**

Setelah tombol Save ditekan, data input dari formulir ditampilkan dalam AlertDialog:

```
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

```

**Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:**

**Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Item.**

**Ketika memiih opsi Halaman Utama, maka aplikasi akan mengarahkan pengguna ke halaman utama.**

**Ketika memiih opsi Tambah Item, maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru.**

```
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Halaman Utama'),
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  },
),
ListTile(
  leading: const Icon(Icons.add_circle_outline_rounded),
  title: const Text('Tambah Produk'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemEntryFormPage()),
    );
  },
),
```



**Apa kegunaan const di Flutter? Jelaskan apa keuntungan ketika menggunakan const pada kode Flutter. Kapan sebaiknya kita menggunakan const, dan kapan sebaiknya tidak digunakan?**

const digunakan untuk mendefinisikan objek yang bersifat immutable, artinya nilainya tidak akan berubah selama runtime. Menggunakan const di Flutter bermanfaat dalam meningkatkan performa aplikasi karena widget yang didefinisikan dengan const hanya dibuat satu kali dan dapat digunakan kembali, sehingga mengurangi jumlah alokasi memori. Sebaiknya gunakan const ketika widget atau nilai tidak akan berubah setelah inisialisasi. Jika nilai tersebut dapat berubah, gunakan final atau tanpa modifier.


**Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!**

Column digunakan untuk menyusun widget secara vertikal (dari atas ke bawah), sementara Row untuk menyusun secara horizontal (dari kiri ke kanan).

Contoh Column:
```
Column(
  children: [
    Text("Text 1"),
    Text("Text 2"),
    Text("Text 3"),
  ],
);
```
Contoh Row:
```
Row(
  children: [
    Icon(Icons.star),
    Text("Row Example"),
  ],
);
```

**Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!**

Pada halaman form yang dibuat, elemen input yang digunakan adalah TextFormField untuk input tipe produk, nama produk, harga produk, dan deskripsi produk.

Terdapat elemen input Flutter lain yang tidak digunakan pada tugas ini, seperti Checkbox, Switch, DropdownButton, dan DatePicker. Elemen ini dapat digunakan sesuai kebutuhan, misalnya DropdownButton untuk pilihan kategori atau DatePicker untuk tanggal.

**Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?**

Untuk konsistensi tampilan, tema diatur pada MaterialApp di bagian theme, menggunakan ThemeData. Contohnya:
```
theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.lightBlue,
    ).copyWith(secondary: Colors.lightBlue[50]),
);
```

**Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?**

Navigasi dalam aplikasi dilakukan menggunakan Navigator. Untuk berpindah halaman, digunakan Navigator.push() untuk membuka halaman baru dan Navigator.pushReplacement() untuk mengganti halaman saat ini dengan halaman yang baru. Contohnya:

```
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ItemEntryFormPage()),
);
```
Akaan menavigasi ke page item entry form.