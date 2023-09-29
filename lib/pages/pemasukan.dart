import 'package:flutter_sertifikasi/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pemasukan extends StatefulWidget {
  Pemasukan({Key? key}) : super(key: key);

  @override
  State<Pemasukan> createState() => _Pemasukan();
}

class _Pemasukan extends State<Pemasukan> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final DbHelper dbHelper = DbHelper();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void resetForm() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    amountController.clear();
    descriptionController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pemasukan"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: dateController,
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Tanggal",
              labelStyle: TextStyle(color: Colors.green),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.money),
              labelText: "Nominal",
              labelStyle: TextStyle(color: Colors.green),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: "Keterangan",
              labelStyle: TextStyle(color: Colors.green),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)))),
                  onPressed: () {
                    resetForm();
                  },
                  child: const Text("Reset"),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightGreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)))),
                  onPressed: () async {
                    String date = dateController.text;
                    String amount = amountController.text;
                    String description = descriptionController.text;

                    if (date.isNotEmpty && amount.isNotEmpty) {
                      int rowCount = await dbHelper.insertIncome(
                          date, amount, description);
                      if (rowCount > 0) {
                        resetForm();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Pemasukan berhasil disimpan."),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Gagal menyimpan pemasukan."),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Tanggal dan Jumlah harus diisi."),
                        ),
                      );
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 127, 174, 255)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)))),
                  child: const Text("Kembali"),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
