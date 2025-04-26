// To parse this JSON data, do
//
//     final apiStock = apiStockFromJson(jsonString);

import 'dart:convert';

ApiStock apiStockFromJson(String str) => ApiStock.fromJson(json.decode(str));

String apiStockToJson(ApiStock data) => json.encode(data.toJson());

class ApiStock {
    String code;
    int timestamp;
    int gmtoffset;
    double open;
    double high;
    double low;
    double close;
    int volume;
    double previousClose;
    double change;
    double changeP;

    ApiStock({
        required this.code,
        required this.timestamp,
        required this.gmtoffset,
        required this.open,
        required this.high,
        required this.low,
        required this.close,
        required this.volume,
        required this.previousClose,
        required this.change,
        required this.changeP,
    });

    factory ApiStock.fromJson(Map<String, dynamic> json) => ApiStock(
        code: json["code"],
        timestamp: json["timestamp"],
        gmtoffset: json["gmtoffset"],
        open: json["open"]?.toDouble(),
        high: json["high"]?.toDouble(),
        low: json["low"]?.toDouble(),
        close: json["close"]?.toDouble(),
        volume: json["volume"],
        previousClose: json["previousClose"]?.toDouble(),
        change: json["change"]?.toDouble(),
        changeP: json["change_p"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "timestamp": timestamp,
        "gmtoffset": gmtoffset,
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "previousClose": previousClose,
        "change": change,
        "change_p": changeP,
    };
}
