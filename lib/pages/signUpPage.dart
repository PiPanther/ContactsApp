import 'package:app_via_wireframe/controllers/authervices.dart';
import 'package:app_via_wireframe/pages/homepage.dart';
import 'package:app_via_wireframe/utils/buttons.dart';
import 'package:app_via_wireframe/utils/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailCOntroller = TextEditingController();
  TextEditingController passwordCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(205, 35, 33, 33),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.waving_hand,
                    size: 36,
                    color: Colors.white,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: [
                    MyTextField(
                      text: 'Enter Your Email',
                      controller: emailCOntroller,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    MyTextField(
                      text: 'Enter Your Password',
                      controller: passwordCOntroller,
                      keyboardType: null,
                    ),
                  ],
                ),
              ),
              MyButton(
                text: 'Sign Up',
                color: Colors.deepPurple,
                function: () {
                  AuthService()
                      .createAccountWithEmail(
                          emailCOntroller.text, passwordCOntroller.text)
                      .then((value) => {
                            if (value == "Account Created")
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Account created successfully"))),
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()))
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(value)))
                              }
                          });
                },
              ),
              MyButton(
                text: 'Continue with Google',
                color: Colors.deepPurple,
                function: () {},
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an acoount?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
