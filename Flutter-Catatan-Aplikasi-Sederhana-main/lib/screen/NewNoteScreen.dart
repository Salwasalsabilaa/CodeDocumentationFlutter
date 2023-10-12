import 'package:catatanaplikasi_flutter/Note.dart';
import 'package:catatanaplikasi_flutter/database.dart';
import 'package:flutter/material.dart';
import 'package:catatanaplikasi_flutter/main.dart';

///Kelas NewNoteScreen yang mewarisi StatefulWidget. Ini digunakan untuk membuat layar untuk menambahkan catatan baru.
class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

///kelas state _NewNoteScreenState yang mengelola keadaan layar NewNoteScreen. Ini akan menangani input pengguna dan menyimpan catatan baru ke database.
class _NewNoteScreenState extends State<NewNoteScreen> {
  ///variabel dbHelper yang digunakan untuk berinteraksi dengan database menggunakan kelas DBHelper
  var dbHelper;
  ///kunci global (global key) yang digunakan untuk mengelola keadaan formulir yang digunakan untuk mengumpulkan input pengguna.
  final _noteForm = GlobalKey<FormState>();

  ///pengontrol (controller) untuk input judul catatan.
  final titleController = TextEditingController();
  ///pengontrol untuk input isi catatan.
  final bodyController = TextEditingController();

  ///metode initState yang akan dipanggil saat layar NewNoteScreen diinisialisasi. Ini menginisialisasi variabel dbHelper
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  ///metode yang akan dipanggil saat pengguna mengklik tombol "Save" untuk menyimpan catatan baru. Ini akan memvalidasi input pengguna dan jika valid, membuat objek Note baru dan menyimpannya ke database. Selanjutnya, ini akan mengarahkan pengguna kembali ke tampilan utama
  submitNote(context) async {
    if (_noteForm.currentState!.validate()) {
      final newNote =
          Note(title: titleController.text, body: bodyController.text);
      await dbHelper.saveNote(newNote).then({
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyApp()))
      });
    }
  }

  @override
  ///metode yang digunakan untuk membangun tampilan layar NewNoteScreen. Ini termasuk formulir dengan dua input (judul dan isi catatan) serta tombol "Save" untuk menyimpan catatan
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Notes"),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, top: 40, left: 20),
        child: Form(
          key: _noteForm,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  hintText: 'Isi Judul',
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Some Title';
                  return null;
                },
              ),
              TextFormField(
                controller: bodyController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Isi',
                  hintText: 'Isi Catatan',
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter Some Notes';
                  return null;
                },
              ),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => submitNote(context),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
