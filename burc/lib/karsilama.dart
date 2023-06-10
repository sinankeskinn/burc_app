import 'package:flutter/material.dart';

class KarsilamaSayfasi extends StatelessWidget {
  final String ad;
  final String soyad;
  final String eposta;
  final String sifre;
  final String dogumTarihi;

  KarsilamaSayfasi({
    required this.ad,
    required this.soyad,
    required this.eposta,
    required this.sifre,
    required this.dogumTarihi,
  });

  String getBurc() {
    // Doğum tarihine göre burcu hesaplar.
    int day = int.parse(dogumTarihi.substring(8, 10));
    int month = int.parse(dogumTarihi.substring(5, 7));

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return 'Koç';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return 'Boğa';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return 'İkizler';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return 'Yengeç';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return 'Aslan';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return 'Başak';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return 'Terazi';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return 'Akrep';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return 'Yay';
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return 'Oğlak';
    } else if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return 'Kova';
    } else {
      return 'Balık';
    }
  }

  String getBurcGorselLink() {
    // Doğum tarihine göre burç görsel linkini döndürür.
    String burc = getBurc();

    // Burçlara ait görsel linklerini belirleme.
    if (burc == 'Koç') {
      return 'https://zambakulkesi.com/wp-content/uploads/2021/09/koc-burcu.jpg';
    } else if (burc == 'Boğa') {
      return 'https://img-s1.onedio.com/id-62e533394ae38e9930f098b3/rev-0/w-600/h-375/f-jpg/s-793ab77398c4678e96d54fe91515f8337cd7dffb.jpg';
    } else if (burc == 'İkizler') {
      return 'https://www.kizlarduysun.com/wp-content/uploads/2022/08/ikizler-burcunun-10-etkin-ozelligi-696x392-1.jpg';
    } else if (burc == 'Yengeç') {
      return 'https://www.tulomsas.com.tr/wp-content/uploads/2023/03/yengec-burcu.jpg';
    } else if (burc == 'Aslan') {
      return 'https://zambakulkesi.com/wp-content/uploads/2021/09/aslan-burcu-nedir-aslan-burcu-tarihi-nedir-aslan-burcu-ozellikleri-nelerdir-55705.jpg';
    } else if (burc == 'Başak') {
      return 'https://www.tulomsas.com.tr/wp-content/uploads/2023/03/basak-burcu.jpg';
    } else if (burc == 'Terazi') {
      return 'https://astrologjalemuratoglu.com/wp-content/uploads/2020/01/i.jpg';
    } else if (burc == 'Akrep') {
      return 'https://www.tulomsas.com.tr/wp-content/uploads/2023/03/akrep-burcu.jpg';
    } else if (burc == 'Yay') {
      return 'https://ruyayorumcum.com/wp-content/uploads/Yay.jpeg';
    } else if (burc == 'Oğlak') {
      return 'https://cdn.yenicaggazetesi.com.tr/news/2023/04/150420231430027197012.jpg';

    } else if (burc == 'Kova') {
      return 'https://mitr.com.tr/wp-content/uploads/2022/11/kova-burcu-scaled_blog_g1891_696x435_wagfYBYG.jpeg';
    } else {
      return 'https://mitr.com.tr/wp-content/uploads/2022/11/balik-burcu-nedir-balik-burcu-tarihi-nedir-balik-burcu-ozellikleri-nelerdir-55800_blog_g1828_702x336_KsmwtoOk.jpeg';
    }
  }

  @override
  Widget build(BuildContext context) {
    String burc = getBurc();
    String burcGorselLink = getBurcGorselLink();
    String gunlukYorum = 'Harika Bir Gün Sizi Bekliyor..'; // Günlük burç yorumunu burada belirleyebilirsiniz

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('Günlük Burç Yorumu', style: TextStyle(fontSize: (20)),),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://abload.de/img/38h2k7p.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hoş geldiniz!', style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Text('Merhaba $ad $soyad.', style: TextStyle(fontSize: 20)),
            Text('$eposta Adresi ile kayıt olmuşsunuz.', style: TextStyle(fontSize: 16)),
            Text('Şifreniz: $sifre', style: TextStyle(fontSize: 20)),
            Text('Doğum Tarihi: $dogumTarihi', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16.0),
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  burcGorselLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16.0),


            Text('Günlük Burç Yorumu:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: (20))),
            Text(gunlukYorum , style: TextStyle(fontSize: (20)),),
          ],
        ),
      ),
    );
  }
}
