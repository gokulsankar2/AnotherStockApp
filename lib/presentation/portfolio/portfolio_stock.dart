import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whos_the_imposter/core/configs/theme/app_colors.dart';
import 'package:whos_the_imposter/presentation/portfolio/portfolio_stockInfo.dart';

class PortfolioStock extends StatefulWidget {
  final double price;
  final double quantity;
  final String stockSymbol;
  final DateTime? timestamp;
  final String? transactionType;

  const PortfolioStock({
    super.key,
    required this.price,
    required this.quantity,
    required this.stockSymbol,
    this.timestamp,
    this.transactionType,
  });

  factory PortfolioStock.fromDocument(DocumentSnapshot doc) {
    return PortfolioStock(
      price: doc['price'],
      quantity: doc['quantity'],
      stockSymbol: doc['stockSymbol'],
    );
  }

  factory PortfolioStock.fromDocumentWithDetails(DocumentSnapshot doc) {
    return PortfolioStock(
      price: doc['price'],
      quantity: doc['quantity'],
      stockSymbol: doc['stockSymbol'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
      transactionType: doc['transactionType'],
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "Stock: $stockSymbol, Price: $price, Quantity: $quantity";
  }

  @override
  State<PortfolioStock> createState() => _PortfolioStockState();
}

class _PortfolioStockState extends State<PortfolioStock> {
  late double price;
  late double quantity;

  @override
  void initState() {
    super.initState();
    price = widget.price;
    quantity = widget.quantity;
  }

  String getFormattedTimestamp(DateTime timestamp) {
    return "${timestamp.month}/${timestamp.day}/${timestamp.year}";
  }

  String getFormattedTransactionType(String transactionType) {
    return transactionType == 'TransactionType.buy' ? 'Buy' : 'Sell';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PortfolioStockInfo(stockSymbol: widget.stockSymbol),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  widget.stockSymbol,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Price: \$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Quantity: ${quantity.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.timestamp != null) ...[
                Row(
                  children: [
                    Text(
                      "Type: ${getFormattedTransactionType(widget.transactionType!)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      getFormattedTimestamp(widget.timestamp!),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
