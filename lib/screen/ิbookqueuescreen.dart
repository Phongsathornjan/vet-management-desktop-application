import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookQueuePage extends StatefulWidget {
  @override
  _BookQueuePageState createState() => _BookQueuePageState();
}

class _BookQueuePageState extends State<BookQueuePage> {
  int selectedday = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  List<String> availableQueues = [];
  List<String> bookedQueues = [];

  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://your_php_api_url'));
    final data = json.decode(response.body);
    setState(() {
      availableQueues = List<String>.from(data['available_queues']);
      bookedQueues = List<String>.from(data['booked_queues']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Queue'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Month: '),
                DropdownButton<int>(
                  value: selectedMonth,
                  onChanged: (int? value) {
                    setState(() {
                      selectedMonth = value!; // .! คือไม่สามารถเป็น null ได้
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
                Text('Select Day: '),
                DropdownButton<int>(
                  value: selectedday,
                  onChanged: (int? value) {
                    setState(() {
                      selectedday = value!; // .! คือไม่สามารถเป็น null ได้
                    });
                  },
                  items: List.generate(
                    31 - DateTime.now().day,
                    (index) => DropdownMenuItem<int>(
                      value: DateTime.now().day + index,
                      child: Text('${DateTime.now().day + index}'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
