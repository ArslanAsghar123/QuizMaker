import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_maker/helper/function.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/view/home.dart';
import 'package:quiz_maker/view/quiz.dart';
import 'file:///E:/Projects/quiz_maker/lib/Widget/Widgets.dart';
import 'package:quiz_maker/view/signup.dart';
import 'package:quiz_maker/view/splash_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  GoogleSignIn _signin = GoogleSignIn(scopes: ['email']);

  //9797979 AuthService authService = new AuthService;

  bool _isLoading = false;

  Future<void> SignIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        HelperClass.saveUserLoggedInDetails(isLoggedin: true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen1()));

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e.message("Exeption"));
      }
      // ignore: unnecessary_statements
      //context.read<AuthenticationService>().signIn;

    }
  }
  Future<void> googleSignIn() async {
    try {
      GoogleSignInAccount account = await _signin.signIn();
      GoogleSignInAuthentication auth = await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      // Logging In....
      FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(

              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: Stack(

                children: [
                  Form(
                    key: _formKey,
                    child: Container(

                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Spacer(),
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty ? "Enter EmailId" : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.isEmpty ? "Enter Password" : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              SignIn();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              width: MediaQuery.of(context).size.width - 48,
                              alignment: Alignment.center,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              googleSignIn();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),

                              decoration: BoxDecoration(
                                image:  DecorationImage(
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('assets/google_PNG19635.png'),
                                ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              width: MediaQuery.of(context).size.width - 48,
                              alignment: Alignment.center,
                              child: Text(
                                'Google SignIn',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey,fontWeight: FontWeight.w700,fontFamily: 'Quicksand'),

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
