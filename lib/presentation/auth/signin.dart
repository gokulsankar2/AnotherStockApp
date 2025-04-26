import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/common/widgets/button/basic_button.dart';
import 'package:whos_the_imposter/presentation/auth/auth_service.dart';
import 'package:whos_the_imposter/core/configs/theme/basic_textfield.dart';
import 'package:whos_the_imposter/presentation/auth/register.dart';
import 'package:whos_the_imposter/presentation/home/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _email.text;
    final password = _password.text;
    try {
      await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      _auth.exceptionHandler(e.toString());
    }
    // Handle login logic here
    print('Email: $email, Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "If You Need Any Support, Click Here",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BasicTextField(
                hintText: "Enter Username or Email",
                controller: _email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BasicTextField(
                hintText: "Password",
                controller: _password,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Recovery Password",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: BasicButton(
                text: "Sign In",
                onPressed: () {
                  _handleLogin();
                },
                height: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                text: TextSpan(
                  text: "Don't Have An Account ? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Register Now ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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
}
