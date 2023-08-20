import 'package:dinamik_not_uygulamasi/constants/app_constants.dart';
import 'package:dinamik_not_uygulamasi/helper/data_helper.dart';
import 'package:dinamik_not_uygulamasi/model/ders.dart';
import 'package:dinamik_not_uygulamasi/widgets/ders_listesi.dart';
import 'package:dinamik_not_uygulamasi/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfdeger = 4;
  double secilenKredideger = 1;
  String girilenDersAd = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildForm(),
                ),
                Expanded(
                  flex: 1,
                  child: OrtalamaGoster(
                      ortalama: DataHelper.ortalamaHesapla(),
                      dersSayisi: DataHelper.tumEklenenDersler.length),
                ),
              ],
            ),
            Expanded(child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ))
          ],
        ));
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(
          child: _buildTextFromBuild(),
          padding: Sabitler.yatay8Padding,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _buildHarfler(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _buildKrediler(),
              ),
            ),
            IconButton(
              onPressed: _dersEkleveWOrtalamaHesapla,
              icon: Icon(Icons.arrow_forward_ios_sharp),
              color: Sabitler.anaRenk,
              iconSize: 30,
            )
          ],
        ),
        SizedBox(
          height: 5,
        )
      ]),
    );
  }

  TextFormField _buildTextFromBuild() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAd = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Ders adını giriniz";
        } else
          return null;
      },
      decoration: InputDecoration(
          hintText: "Matematik",
          border: OutlineInputBorder(
              borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2)),
    );
  }

  _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenHarfdeger,
        items: DataHelper.tumDerslerinHarfleri(),
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenHarfdeger = deger!;
            print(deger);
          });
        },
        underline: Container(),
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenKredideger,
        items: DataHelper.tumDerslerinKredileri(),
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKredideger = deger!;
            print(deger);
          });
        },
        underline: Container(),
      ),
    );
  }

  void _dersEkleveWOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAd,
          harfDegeri: secilenHarfdeger,
          krediDegeri: secilenKredideger);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
