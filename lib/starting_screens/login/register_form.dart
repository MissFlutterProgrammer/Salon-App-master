// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:salon_app/starting_screens/components/rounded_button.dart';
import 'package:salon_app/starting_screens/components/rounded_input.dart';
import 'package:salon_app/starting_screens/components/rounded_password_input.dart';
import 'package:salon_app/starting_screens/emailverify.dart';

var email_register;
var password_register;
var name_register;
var number_register;

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const SizedBox(height: 40),

                  RoundedInput(
                    icon: Icons.mail,
                    hint: 'email',
                    value: (String valueInput) {
                      email_register = valueInput;
                    },
                  ),
                  RoundedInput(
                    icon: Icons.phone,
                    hint: 'Number without +91',
                    value: (String valueInput) {
                      number_register = valueInput;
                    },
                  ),

                  RoundedInput(
                    icon: Icons.face,
                    hint: 'Name',
                    value: (String valueInput) {
                      name_register = valueInput;
                    },
                  ),

                  RoundedPasswordInput(
                    hint: 'Password',
                    value: (String valueInput) {
                      password_register = valueInput;
                    },
                  ),

                  const SizedBox(height: 10),

                  RoundedButton(
                    title: 'SIGN UP',
                    ontap: () {
                      if (email_register != null &&
                          number_register != null &&
                          name_register != null &&
                          password_register != null) {
                        sendOtp(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Verification(),
                          ),
                        );
                      }
                    },
                  ), //ass register

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
