// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>(),
      _fullNameController = TextEditingController(),
      _emailAdressController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accounts =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?,
        _accountContainer = accounts?['accountContainer'];

    void registerAccount(String fullName, String email, String password) {
      try {
        _accountContainer.add({
          "fullName": fullName,
          "email": email,
          "password": password,
        });
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Legendary Application'),
              content: const Text("Registration Unsuccessful!"),
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

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Legendary Application'),
            content: const Text("Successfully Registered!"),
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
        key: _registerFormKey,
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
                        "Registration Form",
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
                            controller: _fullNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 253, 173, 0),
                              ),
                              labelText: 'Full Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Full Name Is Required.';
                              }

                              return null;
                            },
                          ),
                        ),
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
                            if (_registerFormKey.currentState!.validate()) {
                              registerAccount(
                                  _fullNameController.text,
                                  _emailAdressController.text,
                                  _passwordController.text);

                              _fullNameController.clear();
                              _emailAdressController.clear();
                              _passwordController.clear();
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            backgroundColor:
                                const Color.fromARGB(255, 12, 31, 41),
                          ),
                          child: const Text(
                            "Register",
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
                            const Text("Already have account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: const Text(
                                "login to an existing account",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/');
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
