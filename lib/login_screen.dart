// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String, dynamic>> _accountList = [];
  final _accountContainer = Hive.box('accountList');
  final _loginFormKey = GlobalKey<FormState>(),
      _emailAdressController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void loginAccount() {
    bool isExist = false;
    String email = _emailAdressController.text;
    String password = _passwordController.text;

    for (var value in _accountContainer.values) {
      if (value['email'] == email) {
        if (value['password'] == password) {
          isExist = true;
        }
      }
    }

    if (isExist) {
      Navigator.pushReplacementNamed(context, "/dashboard");
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Legendary Application'),
            content: const Text("Incorrect Password"),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Legendary Application"),
        backgroundColor: const Color.fromARGB(255, 12, 31, 41),
        leading: const Icon(
          Icons.storm,
          color: Color.fromARGB(255, 253, 173, 0),
        ),
      ),
      body: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: const EdgeInsets.all(15.0),
              color: const Color.fromARGB(255, 12, 31, 41),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: Text(
                        "Login Form",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: TextFormField(
                            controller: _emailAdressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 253, 173, 0),
                              ),
                              labelText: 'Email Address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Address Is Required.';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: true,
                            autocorrect: false,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 253, 173, 0),
                              ),
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Is Required.';
                              }

                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_loginFormKey.currentState!.validate()) {
                              loginAccount();
                              _passwordController.clear();
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            backgroundColor:
                                const Color.fromARGB(255, 12, 31, 41),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text("Don't have already account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: const Text(
                                "register now",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/register',
                                    arguments: {
                                      "accountContainer": _accountContainer,
                                    });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
