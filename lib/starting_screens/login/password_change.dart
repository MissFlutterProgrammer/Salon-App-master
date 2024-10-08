// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/starting_screens/login/forgetPassword.dart';
import 'package:salon_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Home_page/HomePage.dart';

String? newpassword;
String? confirmpassword;

class PasswordChange extends StatefulWidget {
  const PasswordChange({Key? key}) : super(key: key);

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  bool _isObscure_pc = true;
  bool _isObscure_cp = true;

  Future<void> UpdatePassword() async {
    var res = await http.post(Uri.parse(url_change_password),
        body: {'email': email_fp, 'password': newpassword});
    var data = await jsonDecode(res.body);
    print(res.body);
    if (data.toString() == 'Success') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('Login', email_fp);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home_Page_Screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFc6ece6),
        title: Text(
          'Change Password',
          style: GoogleFonts.ubuntu(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            shadows: [
              const Shadow(
                // bottomLeft
                offset: Offset(-1.0, -1.0),
                color: Color.fromARGB(255, 196, 196, 196),
              ),
              const Shadow(
                // bottomRight
                offset: Offset(1.0, -1.0),
                color: Color.fromARGB(255, 196, 196, 196),
              ),
              const Shadow(
                // topRight
                offset: Offset(1.0, 1.0),
                color: Color.fromARGB(255, 196, 196, 196),
              ),
              const Shadow(
                // topLeft
                offset: Offset(-1.0, 1.0),
                color: Color.fromARGB(255, 196, 196, 196),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'images/key.png',
              height: 200,
            ),
            Text(
              'Enter your New Password',
              style: GoogleFonts.ubuntu(fontSize: 28),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 1.0,
                child: TextField(
                  onChanged: (value) {
                    newpassword = value;
                  },
                  style: GoogleFonts.ubuntu(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  obscureText: _isObscure_pc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        width: 3,
                        color: Colors.white,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    label: const Text('New Password'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure_pc ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure_pc = !_isObscure_pc;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 1.0,
                child: TextField(
                  onChanged: (value) {
                    confirmpassword = value;
                  },
                  style: GoogleFonts.ubuntu(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  obscureText: _isObscure_cp,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        width: 3,
                        color: Colors.white,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    label: const Text('Confirm Password'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure_cp ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure_cp = !_isObscure_cp;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  width: 2.5,
                  color: Color.fromARGB(255, 57, 255, 225),
                ),
              ),
              onPressed: () {
                if (newpassword == null || confirmpassword == null) {
                  showAlertDialog(context, 'Alert', 'Fill all the details');
                } else if (newpassword != confirmpassword) {
                  showAlertDialog(context, 'Not Matched',
                      'New Password and Confirm Password did not match');
                } else {
                  UpdatePassword();
                }
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color.fromARGB(255, 57, 255, 225),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String titleText, String contentText) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(titleText),
    content: Text(contentText),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
