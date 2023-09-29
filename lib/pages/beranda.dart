import 'package:flutter_sertifikasi/helper/dbhelper.dart';
import 'package:flutter_sertifikasi/constant/routes_constant.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  @override
  _Beranda createState() => _Beranda();
}

class _Beranda extends State<Beranda> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Rangkuman Bulan Ini",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Total Pengeluaran: \Rp $totalExpense",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Total Pemasukan: \Rp $totalIncome",
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/img/grafik.jpg',
                  width: double.infinity, height: 150),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(5.0),
                  crossAxisCount: 2,
                  children: <Widget>[
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, addIncomeRoute);
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset('assets/img/arrows.png',
                                      width: 100, height: 100)),
                              const Text(
                                'Tambah Pemasukan',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 25.0),
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, addExpenseRoute);
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset('assets/img/outcome.png',
                                      width: 100, height: 100)),
                              const Text(
                                'Tambah Pengeluaran',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 25.0),
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                      'assets/img/financial-statement.png',
                                      width: 100,
                                      height: 100)),
                              const Text(
                                'Detail Cash Flow',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 25.0),
                    ),
                    Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, settingsRoute);
                        },
                        splashColor: Colors.green,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset('assets/img/setting.png',
                                      width: 100, height: 100)),
                              const Text(
                                'Pengaturan',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 25.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
