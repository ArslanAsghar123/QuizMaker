import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_maker/helper/function.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/view/home.dart';
import 'package:quiz_maker/view/signin.dart';
import 'package:quiz_maker/view/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoading = false;

  bool _isLoggedin = false;
  @override
  void initState() {
    checkUserLoggedInstatus();
    super.initState();
    // Add code after super
  }

  checkUserLoggedInstatus() async{
     HelperClass.getUserLoggedInDetails().then((value){
       setState(() {
         _isLoggedin = value;
       });
     });
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : (_isLoggedin ?? false) ? Home():  AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {


  @override
  Widget build(BuildContext context) {




    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return SignIn();
    }
    return SignUp();
  }
}
