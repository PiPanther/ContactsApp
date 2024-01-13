import 'package:app_via_wireframe/controllers/authervices.dart';
import 'package:app_via_wireframe/pages/homepage.dart';
import 'package:app_via_wireframe/pages/signUpPage.dart';
import 'package:app_via_wireframe/utils/buttons.dart';
import 'package:app_via_wireframe/utils/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        keyboardType: TextInputType.emailAddress),
                    MyTextField(
                      text: 'Enter Your Password',
                      controller: passwordCOntroller,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              MyButton(
                text: 'Login',
                color: Colors.deepPurple,
                function: () {
                  AuthService()
                      .loginUsingEmail(
                          emailCOntroller.text, passwordCOntroller.text)
                      .then((value) => {
                            if (value == "Logged In")
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Loggin In'))),
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage())),
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value))),
                              }
                          });
                },
              ),
              MyButton(
                text: 'Continue with Google',
                color: Colors.deepPurple,
                function: () {
                  AuthService().continueWithGoogle().then((value) {
                    if (value == "Logged In With Google") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  });
                },
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: Text(
                      'Sign Up',
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
