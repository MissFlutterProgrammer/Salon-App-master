// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/constants.dart';
import 'package:salon_app/starting_screens/login/password_change.dart';

String email_fp = '';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  Future<void> checkemail() async {
    var res = await http
        .post(Uri.parse(url_forgetpassword), body: {'email': email_fp});
    var data = await jsonDecode(res.body);

    if (data.toString() == 'Success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordChange(),
        ),
      );
    } else {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFc6ece6),
        title: Text(
          'Forget Password',
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
            const SizedBox(height: 80),
            Image.asset(
              'images/lock.png',
              height: 200,
            ),
            const SizedBox(height: 30.0),
            Text(
              'Enter your email here',
              style: GoogleFonts.ubuntu(fontSize: 28),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 1.0,
                child: TextField(
                  onChanged: (value) {
                    email_fp = value;
                  },
                  style: GoogleFonts.ubuntu(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(width: 5),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    label: const Text('email'),
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
                checkemail();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  'Submit',
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

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("No such email found"),
    content: const Text("Try to Sign up first"),
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
