import 'package:atik_yonetim/ekranlar/kayitOlEkrani.dart';
import 'package:atik_yonetim/ekranlar/mailSifreEkrani.dart';
import 'package:atik_yonetim/ekranlar/navigasyonBarEkrani.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var uid = FirebaseAuth.instance.currentUser?.uid;
  var a = await FirebaseFirestore.instance.collection("person").doc(uid).get();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(BenimUygulamam());
    } else {
      String isimSoyisim = a.data()!['NameAndSurname'];

      runApp(MyApp(isimSoyisim));
    }
  });

  //var _fireStore=fireStoreService();
  //var uid= FirebaseAuth.instance.currentUser?.uid;

  //List<myData> myList= await _fireStore.getRequests("gTPpjs8k0Eh8KcIueXzE7HFCjZ43");
}

//void main() => runApp(BenimUygulamam());

class BenimUygulamam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ilkSayfa(),
    );
  }
}

class ilkSayfa extends StatefulWidget {
  @override
  State<ilkSayfa> createState() => _ilkSayfaState();
}

class _ilkSayfaState extends State<ilkSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Atık Yönetimi Uygulaması',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Geri Dönüşüm Uygulaması',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  backgroundColor: Colors.lime,
                  radius: 75,
                  backgroundImage:
                      AssetImage('assets/images/geridonusumlogo.jpg'),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 4,
                  child: Text(
                    ''' 
Bir atık daha ne kadar
değerli olabilir ki ''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 335.4,
                    color: Color(0xff009688),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GirisYapEkrani()),
                        );
                      },
                      child: Text('Giriş Yap',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 335.4,
                    color: Color(0xff110F4A),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KayitOlEkrani()),
                        );
                      },
                      child: Text('Kayıt Ol',
                          style: TextStyle(color: Colors.white)),
                    ),
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
