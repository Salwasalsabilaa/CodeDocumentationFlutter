///Mendeklarasikan kelas Note yang merupakan kelas sederhana yang digunakan untuk menyimpan informasi tentang catatan
class Note {
  ///properti atau atribut kelas Note yang digunakan untuk menyimpan judul dan isi catatan. Properti ini dinyatakan sebagai final, yang berarti mereka tidak dapat diubah setelah nilai awalnya ditetapkan.
  final String title;
  final String body;

  ///konstruktor untuk kelas Note. Konstruktor ini mengambil dua parameter, yaitu title dan body, yang harus diberikan saat membuat objek Note. Kata kunci required menunjukkan bahwa kedua parameter ini wajib diisi saat pembuatan objek.
  Note({required this.title, required this.body});

  /// metode yang digunakan untuk mengonversi objek Note menjadi sebuah Map yang berisi informasi judul dan isi catatan. Ini berguna saat Anda ingin menyimpan objek Note ke dalam database atau melakukan serialisasi data.
  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body};
  }

  ///anotasi yang menandakan bahwa metode yang mengikuti akan menggantikan metode yang ada dalam kelas induk, dalam hal ini, metode toString yang ada di kelas Object
  @override
  ///implementasi metode toString yang akan memberikan representasi teks dari objek Note. Ini digunakan ketika Anda ingin mencetak objek Note atau mengonversinya ke string.
  String toString() {
    return 'Note(title: $title, body: $body)';
  }
}
