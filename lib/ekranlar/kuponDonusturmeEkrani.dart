//import 'package:atik_yonetim/yapilar/firmaClassYapisi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Firma {
  String? firmaIsmi;
  Firma({this.firmaIsmi});

  String kodDondur(double kullaniciPuani) {
    double fiyat = kullaniciPuani / 10;

    return "${fiyat}-${firmaIsmi}";
  }
}

class KuponDonusturEkrani extends StatefulWidget {
  @override
  State<KuponDonusturEkrani> createState() => _KuponDonusturEkraniState();
}

class _KuponDonusturEkraniState extends State<KuponDonusturEkrani> {
  double kullaniciToplamPuan = 2312;

  Firma firma1 = Firma(firmaIsmi: 'firma1');

  Firma firma2 = Firma(firmaIsmi: 'firma2');

  Firma firma3 = Firma(firmaIsmi: 'firma3');

  Firma firma4 = Firma(firmaIsmi: 'firma4');

  List<Color> renkler = [
    Colors.red,
    Colors.blue,
    Colors.brown,
    Colors.orangeAccent,
    Colors.teal,
    Colors.black38
  ];
  late List<Firma> firmalar = [firma1, firma2, firma3, firma4];
  bool dialogDurumu = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Text('ToplamPuanMiktarÄ±: ${kullaniciToplamPuan}',
              style: TextStyle(fontSize: 20)),
        ),
      ),
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          itemCount: firmalar.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: GestureDetector(
                onTap: () {
                  TextEditingController controller =
                      new TextEditingController();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '${firmalar[index].firmaIsmi!} firmasÄ± iÃ§in dÃ¶nÃ¼ÅtÃ¼rmek istediÄiniz puanÄ±nÄ±z: '),
                          content: TextField(
                            controller: controller,
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ÃÄ±kÄ±Å',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red[700])),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                var buraninContexti = context;
                                if (kullaniciToplamPuan -
                                        int.parse(controller.text) >=
                                    0) {
                                  if (int.parse(controller.text) >= 1000) {
                                    setState(() {
                                      kullaniciToplamPuan -=
                                          int.parse(controller.text);
                                    });
                                    String geciciMesaj = firmalar[index]
                                        .kodDondur(
                                            double.parse(controller.text));
                                    //Navigator.pop(buraninContexti);
                                    await AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.SUCCES,
                                      headerAnimationLoop: false,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'BaÅarÄ±lÄ±',
                                      desc: 'Kodunuz : ${geciciMesaj}',
                                      buttonsTextStyle:
                                          TextStyle(color: Colors.black),
                                      showCloseIcon: true,
                                      btnCancelOnPress: () {
                                        Navigator.pop(buraninContexti);
                                      },
                                      btnOkOnPress: () {},
                                    )
                                      ..show();
                                  } else {
                                    //Navigator.of(buraninContexti).pop();
                                    await AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      headerAnimationLoop: false,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'BaÅarÄ±sÄ±z',
                                      desc:
                                          'LÃ¼tfen 1000 puan ve Ã¼stÃ¼nde kupon oluÅturma iÅlemi yapÄ±n.',
                                      buttonsTextStyle:
                                          TextStyle(color: Colors.black),
                                      showCloseIcon: true,
                                      btnCancelOnPress: () {
                                        Navigator.pop(buraninContexti);
                                      },
                                      btnOkOnPress: () {},
                                    )
                                      ..show();
                                  }
                                } else {
                                  //Navigator.pop(buraninContexti);
                                  await AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    headerAnimationLoop: false,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'BaÅarÄ±sÄ±z',
                                    desc: 'Yeterli PuanÄ±nÄ±z Yok',
                                    buttonsTextStyle:
                                        TextStyle(color: Colors.black),
                                    showCloseIcon: true,
                                    btnCancelOnPress: () {
                                      Navigator.pop(buraninContexti);
                                    },
                                    btnOkOnPress: () {
                                      Navigator.pop(buraninContexti);
                                    },
                                  )
                                    ..show();
                                }
                                if (dialogDurumu == false) {}
                              },
                              elevation: 5.0,
                              child: Text(
                                'Kupona DÃ¶nÃ¼ÅtÃ¼r',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green[700]),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(firmalar[index].firmaIsmi!,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ),
                  color: renkler[index],
                ),
              ),
            );
          })
    ]);
  }
}
