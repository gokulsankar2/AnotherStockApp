import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/common/widgets/button/basic_button.dart';
import 'package:whos_the_imposter/core/configs/theme/basic_textfield.dart';
import 'package:whos_the_imposter/core/configs/theme/enum_textfield.dart';
import 'package:whos_the_imposter/presentation/auth/auth_service.dart';
import 'package:whos_the_imposter/presentation/home/home.dart';

enum TransactionType {
  buy,
  sell,
}

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _price = TextEditingController();
  final _quantity = TextEditingController();
  final _stockSymbol = TextEditingController();
  final _transactionType = TextEditingController();
  final _timestamp = TextEditingController();

  final _auth = AuthService();

  String? _errorMessage;
  bool _successfulTrans = true;

  @override
  void dispose() {
    _price.dispose();
    _quantity.dispose();
    _stockSymbol.dispose();
    _transactionType.dispose();
    _timestamp.dispose();
    super.dispose();
  }

  Future<void> _handleTransaction() async {
    try {
      if (_price.text.isEmpty || _quantity.text.isEmpty || _stockSymbol.text.isEmpty || _transactionType.text.isEmpty) {
        _successfulTrans = false;
        throw Exception('Missing inputs');
      }
      else {
        _successfulTrans = true;
      }
      
      await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('transactions').doc().set({
        'price': double.parse(_price.text),
        'quantity': double.parse(_quantity.text),
        'stockSymbol': _stockSymbol.text,
        'transactionType': _transactionType.text,
        'timestamp': Timestamp.now(),
      });
    }
    catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      _auth.exceptionHandler(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BasicTextField(
                        hintText: "Price",
                        controller: _price,
                        decimal: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BasicTextField(
                        hintText: "Quantity",
                        controller: _quantity,
                        decimal: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BasicTextField(
                        hintText: "Stock Symbol",
                        controller: _stockSymbol,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: EnumTextField(
                        hintText: "Transaction Type",
                        controller: _transactionType,
                        enumValues: TransactionType.values,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BasicButton(
                        text: "Make Transaction",
                        onPressed: () {
                          _handleTransaction();
                          if(_successfulTrans) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              )
                            );
                          }
                        },
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}