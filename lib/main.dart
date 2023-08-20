import 'package:dinamik_not_uygulamasi/constants/app_constants.dart';
import 'package:dinamik_not_uygulamasi/widgets/ortalama_hesapla_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dinamik Ortalama Hesaplama",
      theme: ThemeData(primarySwatch: Sabitler.anaRenk),
      home: OrtalamaHesaplaPage(),
    );
  }
}
