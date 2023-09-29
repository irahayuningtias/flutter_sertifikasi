import 'package:flutter_sertifikasi/constant/routes_constant.dart';
import 'package:flutter_sertifikasi/pages/pengeluaran.dart';
import 'package:flutter_sertifikasi/pages/pemasukan.dart';
import 'package:flutter_sertifikasi/pages/detail_cashflow.dart';
import 'package:flutter_sertifikasi/pages/beranda.dart';
import 'package:flutter_sertifikasi/pages/login.dart';
import 'package:flutter_sertifikasi/pages/pengaturan.dart';
import 'package:flutter_sertifikasi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => Beranda(),
  settingsRoute: (BuildContext context) => Pengaturan(),
  addExpenseRoute: (BuildContext context) => Pengeluaran(),
  addIncomeRoute: (BuildContext context) => Pemasukan(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlow(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyCashBook App",
      theme: ThemeData(primaryColor: Colors.green.shade800),
      routes: routes,
    );
  }
}
