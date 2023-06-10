import 'package:flutter/material.dart';
import 'database.dart';
import 'karsilama.dart';
import 'package:sqflite/sqflite.dart';
import 'kayitol.dart';
import 'sifre.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _login() async {
    Database database = await DatabaseHelper.createDatabase();

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    List<Map<String, dynamic>> results = await database.query(
      'KULLANICILAR',
      where: 'eposta = ? AND sifre = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      String ad = results[0]['ad'];
      String soyad = results[0]['soyad'];
      String eposta = results[0]['eposta'];
      String sifre = results[0]['sifre'];
      String dogumTarihiString = results[0]['dog_tar'];

      DateTime dogumTarihi = DateTime.parse(dogumTarihiString.replaceAll('.', '-'));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KarsilamaSayfasi(
            ad: ad,
            soyad: soyad,
            eposta: eposta,
            sifre: sifre,
            dogumTarihi: dogumTarihiString,
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Geçersiz e-posta veya şifre';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://abload.de/img/38h2k7p.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Görsel tıklanınca yapılacak işlemler
                  },
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(
                      'https://i2.milimaj.com/i/milliyet/75/1100x570/643bc70d86b247166cd440f7.jpg',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Burcolog Uygulamasına Hoşgeldiniz',
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                  ),
                ),
                SizedBox(height: 22.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    fontSize: (16),
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SifremiUnuttum()),
                        );
                      },
                      child: Text(
                        'Şifremi Unuttum',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 16.0),
                    primary: Color(0xFF0D47A1),
                  ),
                  child: Text('Giriş Yap'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KayitOl()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabın Yok mu ?  ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
