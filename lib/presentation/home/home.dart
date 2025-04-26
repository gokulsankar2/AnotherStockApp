import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/presentation/intro/pages/get_started.dart';
//import 'package:whos_the_imposter/presentation/portfolio/portfolio.dart';
//import 'package:whos_the_imposter/presentation/transactions/transactions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _name;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final auth = FirebaseAuth.instance;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).get();
    setState(() {
      _name = userDoc['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_name != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Hello, $_name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            /* Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                text: TextSpan(
                  text: "Transaction",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Transactions()));
                    },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                text: TextSpan(
                  text: "Portfolio",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Portfolio()));
                    },
                ),
              ),
            ), */
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                text: TextSpan(
                  text: "Not Your Account ? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign Out ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _signout();
                        },
                    )
                  ]
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  _signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GetStarted()),
    );
  }
}
