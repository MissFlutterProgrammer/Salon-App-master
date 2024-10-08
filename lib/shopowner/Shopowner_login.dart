// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/shopowner/customerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/constants.dart';

String _saloshopid = "";
String _salonshopemail = "";
String _salonshopnumber = "";

class Shop_owner_login extends StatefulWidget {
  const Shop_owner_login({Key? key}) : super(key: key);

  @override
  State<Shop_owner_login> createState() => _Shop_owner_loginState();
}

class _Shop_owner_loginState extends State<Shop_owner_login> {
  Future<void> verifiy_owner() async {
    try {
      var res = await http.post(Uri.parse(url_ownerdetail), body: {
        'id': _saloshopid,
        'email': _salonshopemail,
        'number': _salonshopnumber
      });
      var data = await jsonDecode(res.body);
      if (data.toString() != 'Error') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('id', _saloshopid);
        prefs.setString('email_owner', _salonshopemail);
        prefs.setString('num', _salonshopnumber);
        setState(() {
          OwnerDetail = data;
        });
        var res_2 = await http.post(
          Uri.parse(url_todaysbooking),
          body: {'id': prefs.getString('id')},
        );
        var data_2 = await jsonDecode(res_2.body);
        setState(() {
          TodayBooking = data_2;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const customer(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 68, 171, 255),
          title: Text(
            'Verification',
            style: GoogleFonts.ubuntu(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80.0),
              Text(
                'Shopowner Login',
                style: GoogleFonts.ubuntu(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  onChanged: (value) {
                    _saloshopid = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.perm_identity,
                      color: Color.fromARGB(255, 68, 171, 255),
                    ),
                    label: const Text('Salon Id'),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  onChanged: (value) {
                    _salonshopemail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail_outline_outlined,
                      color: Color.fromARGB(255, 68, 171, 255),
                    ),
                    label: const Text('email'),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  onChanged: (value) {
                    _salonshopnumber = value;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 68, 171, 255),
                    ),
                    label: const Text('Number'),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                color: const Color.fromARGB(255, 68, 171, 255),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  //  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  verifiy_owner();
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(70, 8, 70, 8),
                  child: Text(
                    'LogIn',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'New to this app? Then Click',
                style: TextStyle(fontSize: 21),
              ),
              const SizedBox(height: 15),
              MaterialButton(
                color: const Color.fromARGB(255, 114, 191, 255),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  //  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  const String url =
                      'https://docs.google.com/forms/d/e/1FAIpQLSceJY22o43npEg77uxGViJj3bDin_01ilUhxoA0fcNd9hAgDQ/viewform?usp=sf_link';

                  await launchUrl(Uri.parse(url));
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(70, 8, 70, 8),
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
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
