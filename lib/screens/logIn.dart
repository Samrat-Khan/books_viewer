import 'package:books_viewer/service/login/fbAuth.dart';
import 'package:books_viewer/utils/textFiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  bool _logIn = true;

  @override
  void initState() {
    checkAlreadyLoggedIn();
    super.initState();
  }

  checkAlreadyLoggedIn() async {
    User user = await FbAuth.checkAlreadyloggedIn();
    if (user != null) Get.toNamed('/Home');
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  swipeLogInToSignUp() {
    setState(() {
      _logIn = !_logIn;
    });
  }

  facebookLogin() async {
    User user = await FbAuth.signInWithFacebook(context);
    if (user != null) {
      Get.offAllNamed('/Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Card(
            color: Color(0xff212043),
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: size.width * 0.85,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: AnimatedCrossFade(
                firstChild: existingUserWidget(size),
                secondChild: newUserWidget(size),
                crossFadeState: _logIn
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column existingUserWidget(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "sBook",
        ),
        customTextField(
            size: size,
            hintText: "Email",
            controller: _email,
            needMultiline: false,
            widthVal: 0.7),
        customTextField(
            size: size,
            hintText: "Password",
            controller: _password,
            needMultiline: false,
            widthVal: 0.7),
        ElevatedButton(
          onPressed: () {},
          child: Text("Log in"),
        ),
        InkWell(
          onTap: () => swipeLogInToSignUp(),
          child: Text("Don't have an account? Sign Up"),
        ),
        Row(
          children: [
            Spacer(),
            Text("Or LogIn with "),
            InkWell(
              onTap: facebookLogin,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/fb.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Column newUserWidget(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "sBook",
        ),
        Row(
          children: [
            Spacer(),
            customTextField(
                size: size,
                hintText: "First Name",
                controller: _firstName,
                needMultiline: false,
                widthVal: 0.33),
            SizedBox(width: 10),
            customTextField(
                size: size,
                hintText: "Last Name",
                controller: _lastName,
                needMultiline: false,
                widthVal: 0.33),
            Spacer(),
          ],
        ),
        customTextField(
            size: size,
            hintText: "Email",
            controller: _email,
            needMultiline: false,
            widthVal: 0.7),
        customTextField(
            size: size,
            hintText: "Password",
            controller: _password,
            needMultiline: false,
            widthVal: 0.7),
        ElevatedButton(
          onPressed: () {},
          child: Text("Sign up"),
        ),
        InkWell(
          onTap: () => swipeLogInToSignUp(),
          child: Text("Already have an account? Log In"),
        ),
        Row(
          children: [
            Spacer(),
            Text("Or Signup with "),
            InkWell(
              onTap: facebookLogin,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/fb.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
