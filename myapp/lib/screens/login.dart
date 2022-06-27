import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models.dart';
import '../providers/token_provider.dart';
import '../screens/cities_list_page.dart';
import '../widgets/text.dart';
import '../widgets/button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  String err = "";
  bool isLoading = false;

  bool validate() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // Future<Map> loginHandler() async {
  //   debugPrint("\nLogin handler");
  //   Response res = await post(
  //     Uri.parse('http://127.0.0.1:5000/rest/login'),
  //     body: {username: username, password: password}
  //   );

  //   List<dynamic> body = jsonDecode(res.body);

  //   if (res.statusCode == 200) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (builder) => CitiesListPage()
  //       )
  //     );

  // List<City> cities =
  //     body.map((dynamic item) => City.fromJson(item)).toList();

  //     // return cities;

  //   } else {
  //     throw {"Couldn't get cities"};
  //   }
  //   throw "";
  // }

  loginHandler() async {
    debugPrint("\nSending request");

    try {
      var res = await http.post(Uri.parse("http://10.32.3.17:5000/rest/login"),
        body: json.encode({"username": username, "password": password}),
        headers: {"Content-Type": "application/json; charset=UTF-8"}
      );

      if (res.statusCode == 200) {
        debugPrint("\nRequest succesful");
        final data = jsonDecode(res.body);

        // context.read<Token>().updateTOken(data["access_token"]);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) => CitiesListPage()
          )
        );
      } else {
        setState(() => err = "Invalid login details.");
      }
      debugPrint("\n${res.body}");
      setState(() => isLoading = false);
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  void onSubmit() {
    // Hides keyboard
    FocusManager.instance.primaryFocus!.unfocus();

    setState(() => isLoading = true);
    debugPrint("\n\n\nSubmitting");
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      loginHandler();
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Token token = Provider.of<Token>(context);
    
    return Scaffold(
      body: Consumer<Token>(
        builder: (context, value, Widget? child) {
          return Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 160, 20, 20),
              child: Center(
                child: Column(
                  children: [
                    // Login banner
                    const Center(
                      child: TextCustom(
                        text: "Login",
                        color: 0xff000000,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
        
                    const SizedBox(height: 52),
        
                    // Username
                    SizedBox(
                      width: 294,
                      child: TextFormField(
                        decoration:
                          const InputDecoration(labelText: "Username"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter username";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                          setState(() => username = value!)
                      ),
                    ),
        
                    const SizedBox(height: 20),
        
                    // Password
                    SizedBox(
                      width: 294,
                      child: TextFormField(
                        decoration:
                          const InputDecoration(labelText: "Password"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                          setState(() => password = value!)),
                    ),
        
                    const SizedBox(height: 80),
        
                    // Log in button
                    Button(
                      width: 294,
                      height: 60,
                      borderRadius: 20,
                      onPressed: () => onSubmit(),
                      child: Builder(builder: (context) {
                        if (isLoading) {
                          return const CupertinoActivityIndicator();
                        } else {
                          return const TextCustom(
                            text: "Login",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          );
                        }
                      }),
                    ),
        
                    const SizedBox(height: 40),
        
                    // Error message
                    Center(
                      child: TextCustom(
                        text: err,
                        color: 0xffFF0000,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
      )
    );
  }
}
