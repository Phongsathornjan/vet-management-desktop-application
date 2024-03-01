import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/widgets/background_widget.dart';

class StockScreen extends StatefulWidget {
  StockScreen({super.key});

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
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Store',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          actions: const [
            Icon(Icons.search, size: 30, color: Colors.black),
          ],
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: Stack(
          children: [
            background(),
            Container(
              decoration:
                  BoxDecoration(color: const Color.fromARGB(126, 0, 0, 0)),
              width: 2000,
              height: 2000,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 2000,
                height: 500,
                child: ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('ID [' +
                            product[index]['product_id'] +
                            '] ' +
                            product[index]['product_name']),
                        subtitle: Text('คงเหลือ ' +
                            product[index]['product_stock'] +
                            ' ชิ้น ' +
                            ' ราคา ' +
                            product[index]['product_price'] +
                            'ฺBath'),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 550,
              left: 10,
              child: Form(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  width: 1000,
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ค้นหาสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
