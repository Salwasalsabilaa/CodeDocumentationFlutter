import 'package:catatanaplikasi_flutter/Note.dart';
import 'package:catatanaplikasi_flutter/database.dart';
import 'package:catatanaplikasi_flutter/screen/NewNoteScreen.dart';
import 'package:flutter/material.dart';
import 'package:catatanaplikasi_flutter/Note.dart';

///fungsi main yang akan dijalankan saat aplikasi dimulai. Ini memanggil fungsi runApp dengan MyApp sebagai widget utama
void main() {
  runApp(const MyApp());
}

///kelas MyApp yang mewarisi StatelessWidget. Ini digunakan untuk membuat widget yang tidak perlu berubah sepanjang waktu. Ini mengkonfigurasi MaterialApp sebagai elemen tampilan utama aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      home: const MyHomePage(title: 'Aplikasi Catatan'),
    );
  }
}

///kelas MyHomePage yang mewarisi StatefulWidget. Ini adalah tampilan utama aplikasi dan akan menampilkan daftar catatan.
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///kelas state MyHomePage yang digunakan untuk mengelola keadaan tampilan ini. Ini akan mengambil data dari database dan menampilkan daftar catatan.
class _MyHomePageState extends State<MyHomePage> {
  ///variabel notes yang akan digunakan untuk menyimpan daftar catatan. Ini ditandai sebagai "late" karena nilainya akan diinisialisasi nanti.
  late Future<List<Note>> notes;
  ///variabel dbhelper yang akan digunakan untuk berinteraksi dengan database menggunakan kelas DBHelper
  var dbhelper;

  ///metode initState yang akan dipanggil saat tampilan diinisialisasi. Ini menginisialisasi dbhelper dan memanggil loadNotes untuk mengambil catatan dari database.
  void initState() {
    super.initState();
    dbhelper = DBHelper();
    loadNotes();
  }

  /// metode yang digunakan untuk mengambil catatan dari database dan memperbarui variabel notes menggunakan setState
  loadNotes() {
    setState(() {
      notes = dbhelper.getNotes();
    });
  }

  @override
  ///metode yang digunakan untuk membangun tampilan utama aplikasi. Ini termasuk sebuah Scaffold dengan AppBar yang menampilkan judul aplikasi dan daftar catatan yang akan ditampilkan dengan menggunakan FutureBuilder
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      ///widget yang digunakan untuk mengambil data masa depan (seperti daftar catatan) dan membangun tampilan berdasarkan status pengambilan data tersebut (berhasil, gagal, atau sedang memuat)
      body: FutureBuilder(
        future: notes,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          var snapshot2 = snapshot;
          if (snapshot.hasData) {
            //Success
            if (snapshot.data!.length == 0)
              return Center(
                child: Text('Still Empty'),
              );

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final currentItem = snapshot.data![index];
                  return ListTile(title: Text('${currentItem.title}'));
                },
              ),
            );
          } else if (snapshot.hasError) {
            //Error
            return Center(
              child: Text('error fetching notes'),
            );
          } else {
            //Loading
            return CircularProgressIndicator();
          }
        },
      ),
      //Membuat tombol add pada screen / UI
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(),
            ),
          );
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
