import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/presentation/auth/auth_service.dart';
import 'package:whos_the_imposter/presentation/portfolio/portfolio_stock.dart';

class PortfolioStockInfo extends StatefulWidget {
  final String stockSymbol;
  
  const PortfolioStockInfo({
    super.key,
    required this.stockSymbol,
  });

  @override
  State<PortfolioStockInfo> createState() => _PortfolioStockinfoState();
}

class _PortfolioStockinfoState extends State<PortfolioStockInfo> {
  final _auth = AuthService();
  final List<PortfolioStock> portfolioStockInfo = [];

  Future<void> _portfolioStockInfo() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid)
                                         .collection('transactions').where('stockSymbol', isEqualTo: widget.stockSymbol)
                                         .orderBy('timestamp').get();
    for(var doc in snapshot.docs) {
      portfolioStockInfo.add(PortfolioStock.fromDocumentWithDetails(doc));
    }

    setState(() {
      PortfolioStockInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    _portfolioStockInfo();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1, // Adjust the height as needed
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: portfolioStockInfo.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: portfolioStockInfo[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}