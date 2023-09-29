import 'package:flutter_sertifikasi/helper/dbhelper.dart';
import 'package:flutter_sertifikasi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sertifikasi/providers/user_provider.dart';

class Pengaturan extends StatefulWidget {
  @override
  _Pengaturan createState() => _Pengaturan();
}

class _Pengaturan extends State<Pengaturan> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String developerName = "Indah Rahayuningtias";
  String developerNim = "2141764085";
  String dateApp = "25 September 2023";

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                "Ubah Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
                labelStyle: TextStyle(color: Colors.green),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                labelStyle: TextStyle(color: Colors.green),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)))),
              child: const Text("Simpan Password Baru"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 127, 174, 255)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)))),
                child: const Text("Kembali")),
            const SizedBox(height: 40),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/img/profile.jpg'),
                  radius: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // create bold heading style
                      const Text(
                        "About this App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text("Aplikasi ini dibuat oleh: "),
                      Text("Nama : $developerName"),
                      Text("Nim : $developerNim"),
                      Text("Tanggal : $dateApp"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.email!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
