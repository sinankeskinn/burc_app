import 'package:flutter/material.dart';
import 'database.dart';
import 'girissayfasi.dart';
import 'package:sqflite/sqflite.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  Future<void> _resetPassword() async {
    Database database = await DatabaseHelper.createDatabase();

    String email = _emailController.text.trim();

    // E-posta kontrolü yapılır.

    List<Map<String, dynamic>> result = await database.query(
      'KULLANICILAR',
      where: 'eposta = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      // Şifreyi sıfırla
      await database.update(
        'KULLANICILAR',
        {'sifre': 'Abcd1234%'},
        where: 'eposta = ?',
        whereArgs: [email],
      );

      showAlertDialog('Şifreniz Sıfırlandı.', 'Yeni Şifreniz E-Posta Adresinize Gönderildi.');
    } else {
      setState(() {
        _errorMessage = 'Bu e-posta kayıtlı değil.';
      });
    }
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GirisSayfasi()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifremi Yenileme Ekranı'),
        backgroundColor: Color(0xFF1A237E), // Başlık arka plan rengi için renk kodu belirlendi.
      ),
      body: Container(
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
              Flexible(
                child: Text(
                  'Şifremi Unuttum',
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Düğmeler yatay olarak hizalandı.
                children: [
                  ElevatedButton(
                    onPressed: _resetPassword,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 140.0, vertical: 16.0),
                      primary: Color(0xFF1A237E),
                    ),
                    child: Text('Şifreyi Sıfırla'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
