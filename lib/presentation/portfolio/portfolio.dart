import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/presentation/auth/auth_service.dart';
import 'package:whos_the_imposter/presentation/portfolio/portfolio_stock.dart';
import 'package:http/http.dart' as http;

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final List<PortfolioStock> portfolioStocks = [];
  final _auth = AuthService();

  // Fetch real-time price with minimal API calls
  Future<double> _fetchRealTimePrice(String stockSymbol) async {
    const String apiToken = "demo"; // Replace with your API token

    final Uri url = Uri.parse("https://eodhd.com/api/real-time/$stockSymbol?api_token=$apiToken&fmt=json");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data["close"] as num).toDouble(); // Extract latest price
      } else {
        print("Failed to fetch price for $stockSymbol: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching price for $stockSymbol: $e");
    }

    return 0.0; // Default price if API fails
  }

  Future<void> _fetchPortfolioStocks() async {
    Map<String, double> stockQuantity = {};
    
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('transactions')
        .orderBy('stockSymbol')
        .get();
    
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final stockSymbol = data['stockSymbol'] as String;
      final quantity = (data['quantity'] as num).toDouble();
      final isBuy = (data['isBuy'] as bool?) ?? true; // Default to true


      if (isBuy) {
      stockQuantity[stockSymbol] = (stockQuantity[stockSymbol] ?? 0) + quantity;
      } else {
      stockQuantity[stockSymbol] = (stockQuantity[stockSymbol] ?? 0) - quantity;
      }
    }

    // Remove stocks with zero or negative quantities
    stockQuantity.removeWhere((key, value) => value <= 0);

    for (var entry in stockQuantity.entries) {
      final stockSymbol = entry.key;
      final quantity = entry.value;
      final price = await _fetchRealTimePrice(stockSymbol);

      setState(() {
        portfolioStocks.add(PortfolioStock(
          price: price * quantity,
          quantity: quantity,
          stockSymbol: stockSymbol,
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPortfolioStocks();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0), // Add this line for spacing
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Portfolio",
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: portfolioStocks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: portfolioStocks[index],
                    );
                  },
                )
              ],
            ),
          )
        ),
      )
    );
  }
}