import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class StockScreen extends StatefulWidget {
  StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List product = [];

  TextEditingController idsearch = TextEditingController();
  TextEditingController iddelete = TextEditingController();

  Future<void> getrecord(String ids, String idd) async {
    String uri = "http://127.0.0.1/php_api/view_product.php";
    if (ids != "") {
      uri = "http://127.0.0.1/php_api/view_product.php?idsearch=$ids";
    } else if (idd != "") {
      uri = "http://127.0.0.1/php_api/view_product.php?iddelete=$idd";
    }

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
    getrecord("", "");
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
          ),
        ),
        actions: const [
          Icon(Icons.search, size: 30, color: Colors.black),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: <Widget>[
          background(),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(126, 0, 0, 0),
            ),
            width: 2000,
            height: 2000,
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Container(
              width: 1000,
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
            top: 60,
            left: 1200,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 300,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: idsearch,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product ID'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord(idsearch.text, "");
                      },
                      hinText: 'Search',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 1200,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 300,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: iddelete,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product ID'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord("", iddelete.text);
                      },
                      hinText: 'Delete',
                      color: Color.fromARGB(255, 255, 95, 95),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 480,
            left: 1200,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 300,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    MyButton(
                      onTap: () {},
                      hinText: 'Add New Product',
                      color: Color.fromARGB(255, 91, 255, 113),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
