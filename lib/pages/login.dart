import 'package:flutter_sertifikasi/constant/routes_constant.dart';
import 'package:flutter_sertifikasi/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sertifikasi/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/wallet.png',
                      width: 200,
                      height: 150,
                    ),
                    const SizedBox(height: 10), // Add spacing
                    Text(
                      "MyCashBook App v1.0",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelText: 'Email',
                      hintText: "Enter valid email",
                      labelStyle: TextStyle(color: Colors.green)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                      labelStyle: TextStyle(color: Colors.green)),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, attempt to log in
                      final email = emailController.text;
                      final password = passwordController.text;

                      // Call the login function from DbHelper
                      final loginSuccessful =
                          await dbHelper.loginUser(email, password);

                      if (loginSuccessful) {
                        // fetch user data
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        await userProvider.fetchUserByEmail(email);
                        Navigator.pushNamed(context, homeRoute);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Login Failed'),
                            content: const Text('Invalid email or password'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
