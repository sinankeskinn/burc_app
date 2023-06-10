import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> createDatabase() async {
    // Veritabanının kaydedileceği dizin ve adı.
    String databasePath = await getDatabasesPath();
    String databaseName = 'kullanici.db';
    String path = join(databasePath, databaseName);

    // Veritabanını oluşturma.
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Kullanıcılar tablosunu oluşturma.
        await db.execute('''
          CREATE TABLE KULLANICILAR(
            eposta VARCHAR(70) PRIMARY KEY,
            ad VARCHAR(30),
            soyad VARCHAR(25),
            dog_tar DATE,
            sifre VARCHAR(20)
          )
        ''');

        // Hazır veriler.
        await db.rawInsert('''
          INSERT INTO KULLANICILAR(ad, soyad, dog_tar, eposta, sifre)
          VALUES('Harry Potter', 'TheOne', '1995-01-01', 'harry@theone.com', 'Harry01%')
        ''');

        await db.rawInsert('''
          INSERT INTO KULLANICILAR(ad, soyad, dog_tar, eposta, sifre)
          VALUES('Gandalf', 'TheGray', '0033-07-03', 'gandi@oppsaruman.com', 'Gray33%')
        ''');

        await db.rawInsert("""
          INSERT INTO KULLANICILAR(ad, soyad, dog_tar, eposta, sifre)
          VALUES('Vecihi', 'Uçanman', '1956-02-18', 'goklerbenim@hotmail.com', 'Adam271\$')
        """);


      },
    );

    return database;
  }


}
