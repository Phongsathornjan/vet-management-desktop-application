import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List product = [];

  Future<void> getrecord() async {
    //String uri = "http://10.0.2.2/php_api/view_product.php";
    String uri = "http://127.0.0.1/php_api/view_product.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        product = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: product.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(product[index]['product_name']),
            subtitle: Text('คงเหลือ ' +
                product[index]['product_stock'] +
                ' ชิ้น ' +
                ' ราคา ' +
                product[index]['product_price'] +
                ' บาท'),
          ),
        );
      },
    ));
  }
}
