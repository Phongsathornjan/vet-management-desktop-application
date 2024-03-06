import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class BookQueueScreen extends StatefulWidget {
  const BookQueueScreen({super.key});

  @override
  State<BookQueueScreen> createState() => _BookQueueScreenState();
}

class _BookQueueScreenState extends State<BookQueueScreen> {
  List product = [];
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  TextEditingController booking_datetime = TextEditingController();
  TextEditingController id_booker = TextEditingController();

  Future<void> getrecord(String ids, String idd) async {
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

  void _showMyDialog(String txtMsg) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 228, 180, 118),
            title: const Text('status'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ));
        });
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
            'จองคิว',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
            top: 180,
            left: 1100,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 480,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: booking_datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('เวลานัดหมาย'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: id_booker,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('ชื่อผู้จอง'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {},
                      hinText: 'Add New Product',
                      color: Color.fromARGB(255, 82, 255, 67),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 1100,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(200, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  width: 480,
                  height: 130,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Select Year: '),
                      DropdownButton<int>(
                        value: selectedYear,
                        onChanged: (int? value) {
                          setState(() {
                            selectedYear = value!;
                          });
                        },
                        items: List.generate(
                          10,
                          (index) => DropdownMenuItem<int>(
                            value: DateTime.now().year + index,
                            child: Text('${DateTime.now().year + index}'),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text('Select Month: '),
                      DropdownButton<int>(
                        value: selectedMonth,
                        onChanged: (int? value) {
                          setState(() {
                            selectedMonth = value!;
                          });
                        },
                        items: List.generate(
                          12,
                          (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text('${index + 1}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
