import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/presentation/home/main_screen.dart';
import 'package:whos_the_imposter/presentation/intro/pages/get_started.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return const Center(child: Text("Error"),);
          }
          else {
            if (snapshot.data == null) {
              return GetStarted();
            }
            else {
              return MainScreen();
            }
          }
        }
      )
    );
  }
}