**Membuat sebuah program Flutter baru dengan tema E-Commerce yang sesuai dengan tugas-tugas sebelumnya.**

1. Membuat direktori lokal flutter, menjalankan 
```
flutter create consign_pbp

```
2. Lalu masuk ke direktori proyek itu dengan cd

**Membuat tiga tombol sederhana dengan ikon dan teks untuk:**
Melihat daftar produk (Lihat Daftar Produk)
Menambah produk (Tambah Produk)
Logout (Logout)

1. Membuat class ItemHomepage berisi name, icon, dan color
```
class ItemHomepage {
     final String name;
     final IconData icon;
     final Color color;

     ItemHomepage(this.name, this.icon, this.color);
 }
```

2. Pada class MyHomepage membuat list ItemHomepage yang berisi tombol yang ingin ditambahkan.
```
final List<ItemHomepage> items = [
         ItemHomepage("Lihat Daftar Produk", Icons.shopping_cart_rounded, Colors.lightBlue),
         ItemHomepage("Tambah Produk", Icons.add_circle_outline_rounded, Colors.teal),
         ItemHomepage("Logout", Icons.logout_rounded, Colors.redAccent),
  ];
```
**Mengimplementasikan warna-warna yang berbeda untuk setiap tombol (Lihat Daftar Produk, Tambah Produk, dan Logout).**
1. Membuat atribut color pada class ItemHomepage
2. Pada class MyHomepage, atur warna dari tiap tombol di list ItemHomepage.


**Memunculkan Snackbar dengan tulisan:**
"Kamu telah menekan tombol Lihat Daftar Produk" ketika tombol Lihat Daftar Produk ditekan.
"Kamu telah menekan tombol Tambah Produk" ketika tombol Tambah Produk ditekan.
"Kamu telah menekan tombol Logout" ketika tombol Logout ditekan.

1. Tambahkan kode di class ItemCard
```
....
child: InkWell(
        // Aksi ketika kartu ditekan.
        onTap: () {
          // Menampilkan pesan SnackBar saat kartu ditekan.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
)
....
```

**Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.**
1. Stateless widget: widget tanpa state yang bisa berubah, dibuat untuk elemen UI yang statis, seperti Text, Icon, Container
2. Stateful widget: widget dengan state yang bisa berubah, dibuat untuk elemen UI yang perlu diperbarui atau berinteraksi dengan pengguna, seperti Checkbox, Slider, TextField

Dalam pengaturan state, StatelessWidget tidak memiliki fungsi setState, namun StatefulWidget punya.

**Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.**
Berikut adalah widget-widget yang digunakan dalam proyek ini beserta fungsinya:

1. MaterialApp: Widget utama yang mengatur tema, title, dan root halaman aplikasi.

2. Scaffold: Memberikan struktur dasar aplikasi, seperti AppBar di bagian atas dan area body untuk konten utama.

3. AppBar: Bagian atas halaman (header) yang menampilkan judul aplikasi ("Consign!").

4. Padding: Memberikan jarak atau ruang di sekitar widget untuk tata letak yang lebih rapi.

5. Column: Menyusun widget secara vertikal.

6. Row: Menyusun widget secara horizontal, digunakan untuk menampilkan tiga **InfoCard** secara berdampingan.

7. InfoCard: Widget khusus yang menampilkan informasi berupa "NPM", "Nama", dan "Kelas" dalam bentuk kartu.

8. Card: Membuat elemen tampak seperti kartu dengan efek bayangan, digunakan dalam **InfoCard** untuk menampilkan informasi.

9. Text: Menampilkan teks, digunakan untuk menampilkan "NPM", "Nama", "Kelas", judul aplikasi, dan teks sambutan.

10. SizedBox: Memberikan jarak vertikal antar-widget untuk tata letak yang lebih baik.

11. Center: Mengatur widget agar berada di tengah area yang tersedia.

12. GridView.count: Menyusun **ItemCard** dalam bentuk grid dengan tiga kolom, berguna untuk menampilkan daftar produk.

13. ItemCard: Widget yang menampilkan ikon dan teks untuk setiap item menu seperti "Lihat Daftar Produk", "Tambah Produk", dan "Logout".

14. InkWell: Menambahkan efek klik pada widget, digunakan pada **ItemCard** untuk memberikan aksi saat tombol ditekan.

15. SnackBar: Menampilkan pesan sementara di bagian bawah layar saat tombol **ItemCard** ditekan.

16. Icon: Menampilkan ikon di dalam **ItemCard** untuk menggambarkan setiap item menu.


**Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.**
Fungsi setState() dalam Flutter digunakan untuk memberi tahu framework bahwa state suatu widget telah berubah dan harus dirender ulang dengan data terbaru. Ini hanya dapat digunakan dalam widget yang bersifat Stateful Widget, karena hanya widget jenis ini yang memiliki state yang dapat berubah selama runtime.

**Jelaskan perbedaan antara const dengan final.**
const digunakan ketika kita memiliki nilai tetap yang sudah pasti tidak akan berubah,
Contoh const pi = 3.14


Sedangkan final ketika nilai akan tetap setelah ditulis, tapi mungkin perlu diambil ketika runtime,
contoh : final username = fetchUsername()


