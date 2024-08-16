// ignore_for_file: file_names, camel_case_types, avoid_print, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'package:salon_app/Home_page/search_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/constants.dart';
import 'package:salon_app/screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screen/bookscreen.dart';

class Home_Page_Screen extends StatefulWidget {
  const Home_Page_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Page_Screen> createState() => _Home_Page_ScreenState();
}

class _Home_Page_ScreenState extends State<Home_Page_Screen> {
  getProfiledetail(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('register') != null) {
      email_profile = prefs.getString('register');
    } else {
      email_profile = prefs.getString('Login');
    }

    var response = await http
        .post(Uri.parse(url_userdetail), body: {'email': email_profile});
    print(response.body);
    var data = jsonDecode(response.body);
    setState(() {
      username = data[0]['name'].toString();

      var userImageData = data[0]['Profile_Picture'];
      print(userImageData);

      if (userImageData == '') {
        user_image = null;
      } else if (userImageData == null) {
        user_image = null;
      } else {
        user_image = File(data[0]['Profile_Picture']);
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }

  Future<void> getplaces() async {
    try {
      var response = await http.get(Uri.parse(url_getdata));
      var data = await jsonDecode(response.body);
      setState(() {
        Salon_image = data;
      });

      for (int i = 0; i < Salon_image.length; i++) {
        searchedTerms.add(Salon_image[i]['search_address']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getplaces();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0, top: 8.0),
                child: GestureDetector(
                  onTap: () {
                    getProfiledetail(context);
                  },
                  child: const Icon(
                    Icons.account_circle_sharp,
                    size: 50.0,
                  ),
                ),
              ),
            ],
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(
            //       bottom: Radius.circular(10),
            //     ),
            //   ),
            backgroundColor: const Color.fromARGB(255, 44, 149, 254),
            title: Text(
              'Salon App',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg2.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  child: Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              'Search Location...',
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: double.infinity,
                              width: 60,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: Color.fromARGB(255, 91, 173, 255),
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: Salon_image.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          salon_id = int.parse(Salon_image[index]['salonid']);
                          String forCard = Salon_image[index]['salonid'];
                          card_position = int.parse(forCard) - 1;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Salon_screen(),
                            ),
                          );
                        },
                        child: Card(
                          shadowColor: const Color.fromARGB(255, 0, 2, 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: kCardColor,
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 140,
                                  width: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        uploaded_images +
                                            Salon_image[index]['image_name'],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30.0),
                                Flexible(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: Salon_image[index]['Name'],
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n\n' +
                                              Salon_image[index]['address'],
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 44, 149, 254),
          onPressed: () {
            getplaces();
          },
          label: Text(
            'Refresh',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(
            Icons.refresh,
          ),
        ),
      ),
    );
  }
}
