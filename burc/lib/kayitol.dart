import 'package:flutter/material.dart';
import 'database.dart';
import 'girissayfasi.dart';
import 'package:sqflite/sqflite.dart';

class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _adController = TextEditingController();
  TextEditingController _soyadController = TextEditingController();
  TextEditingController _dogumTarihiController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _errorMessage = '';
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _adController.dispose();
    _soyadController.dispose();
    _dogumTarihiController.dispose();
    _passwordController.removeListener(_validatePassword);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _errorMessage = '';
      });
    } else if (!_isPasswordValid(password)) {
      setState(() {
        _errorMessage = 'Şifre geçerlilik kurallarını sağlamalıdır.';
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
    }
  }

  bool _isPasswordValid(String password) {
    // En az bir büyük harf içermeli
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // En az bir küçük harf içermeli
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    // En az bir sayı içermeli
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    // En az bir özel karakter içermeli
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    // En az 7, en çok 15 karakter olmalı
    if (password.length < 7 || password.length > 15) {
      return false;
    }

    return true;
  }

  Future<void> _register() async {
    try {
      String email = _emailController.text.trim();
      String ad = _adController.text.trim();
      String soyad = _soyadController.text.trim();
      String dogumTarihiText = _dogumTarihiController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      // Gerekli alanların doldurulduğunu kontrol et
      if (email.isEmpty ||
          ad.isEmpty ||
          soyad.isEmpty ||
          dogumTarihiText.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        setState(() {
          _errorMessage = 'Lütfen tüm alanları doldurun.';
        });
        return;
      }

      // Şifrelerin eşleştiğini kontrol et
      if (password != confirmPassword) {
        setState(() {
          _errorMessage = 'Şifreler eşleşmiyor!';
        });
        return;
      }

      // Şifre kısıtlamalarını kontrol et
      if (!_isPasswordValid(password)) {
        setState(() {
          _errorMessage = 'Şifre geçerlilik kurallarını sağlamalıdır.';
        });
        return;
      }

      Database database = await DatabaseHelper.createDatabase();

      List<String> tarihParcalari = dogumTarihiText.split('.');
      String formattedTarih = "${tarihParcalari[2]}-${tarihParcalari[1]}-${tarihParcalari[0]}";

      int result = await database.insert('KULLANICILAR', {
        'eposta': email,
        'ad': ad,
        'soyad': soyad,
        'dog_tar': formattedTarih,
        'sifre': password,
      });

      if (result != 0) {
        Navigator.push(

          context,
          MaterialPageRoute(builder: (context) => GirisSayfasi()),
        );
      } else {
        setState(() {
          _errorMessage = 'Kayıt oluşturulurken bir hata oluştu.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Bir hata oluştu: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009688),
        title: Text('Kullanıcı Kayıt Ekranı'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://abload.de/img/38h2k7p.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kayıt Ol',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF009688),
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
              TextField(
                controller: _adController,
                decoration: InputDecoration(
                  labelText: 'Ad',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _soyadController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _dogumTarihiController,
                decoration: InputDecoration(
                  labelText: 'Doğum Tarihi (gg.aa.yyyy)',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Şifre Tekrar',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 16.0),
                  primary: Color(0xFF009688),
                ),
                child: Text('Kayıt Ol'),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
