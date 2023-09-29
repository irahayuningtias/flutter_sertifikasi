import 'package:flutter_sertifikasi/constant/tipe_constant.dart';
import 'package:flutter_sertifikasi/helper/dbhelper.dart';
import 'package:flutter_sertifikasi/models/finance.dart';
import 'package:flutter/material.dart';

class DetailCashFlow extends StatefulWidget {
  @override
  _DetailCashFlow createState() => _DetailCashFlow();
}

class _DetailCashFlow extends State<DetailCashFlow> {
  List<Finance> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database
    List<Finance> data = await dbHelper.getFinance();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb(); // Initialize the database

    // Delete the item from the database
    await dbHelper.deleteDataFinance(cashFlowData[index].id!);

    // Remove the item from the list
    setState(() {
      cashFlowData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Cash Flow"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: cashFlowData.length,
        itemBuilder: (context, index) {
          final item = cashFlowData[index];
          final isIncome = item.type == incomeType;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: ListTile(
              leading: Icon(
                isIncome ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                color: isIncome ? Colors.green : Colors.red,
              ),
              title: Text(item.date!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${isIncome ? 'Pemasukan' : 'Pengeluaran'}: ${item.amount}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Deskripsi: ${item.description}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () async {
                  _deleteItem(index);
                },
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}
