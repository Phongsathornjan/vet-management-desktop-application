import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/component/drowdown.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'dart:convert';

import 'package:vet_desktop/widgets/background_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class BookQueuePage extends StatefulWidget {
  @override
  _BookQueuePageState createState() => _BookQueuePageState();
}

class _BookQueuePageState extends State<BookQueuePage> {
  String booktime = '';
  String cancel = '';
  String admininsert = '';

  TextEditingController name_booker = TextEditingController();
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  List data = [];

  bool isLoading =
      false; // เพิ่มตัวแปร isLoading เพื่อตรวจสอบสถานะการโหลดข้อมูล

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchData();
  }

  Future<void> fetchData() async {
    String uri = "https://setest123.000webhostapp.com/php_api/view_queue.php";
    // String uri = "http://127.0.0.1/php_api/view_queue.php";
    try {
      setState(() {
        isLoading = true; // ตั้งค่า isLoading เป็น true เมื่อเริ่มโหลดข้อมูล
      });
      var res = await http.post(Uri.parse(uri), body: {
        "year": _selectedDay.year.toString(),
        "month": _selectedDay.month.toString(),
        "day": _selectedDay.day.toString(),
        "booktime": booktime,
        "cancel": cancel,
        "id_booker": name_booker.text,
        "admininsert": admininsert,
      });
      setState(() {
        data = jsonDecode(res.body);
        isLoading =
            false; // ตั้งค่า isLoading เป็น false เมื่อโหลดข้อมูลเสร็จสิ้น
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading =
            false; // ตั้งค่า isLoading เป็น false ในกรณีที่เกิดข้อผิดพลาด
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Book Queue')),
      ),
      body: Stack(
        children: [
          background(),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(126, 0, 0, 0),
            ),
            width: 2000,
            height: 2000,
          ),
          Positioned(
            top: 10,
            left: 540,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 720,
              height: 420,
              child: TableCalendar(
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  booktime = '';
                  print(_selectedDay.year);
                  print(_selectedDay.month);
                  print(_selectedDay.day);
                  fetchData();
                },
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 500,
              height: 420,
              child: Column(
                children: [
                  Text(
                    'สถานะคิว',
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(data[index]['booking_datetime']),
                                subtitle: Text(
                                    data[index]['queue_status'] +
                                        '    ' +
                                        data[index]['id_booker'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 500,
              height: 190,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: name_booker,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('ชื่อผู้จอง'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        TimeDropdownWidget(
                          onChanged: (String newValue) {
                            // ทำสิ่งที่คุณต้องการเมื่อเปลี่ยนเวลา
                            booktime = '$newValue';
                          },
                          selectedTime: '10:00:00', // เวลาที่เลือกเริ่มต้น
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            Container(
                              width: 200,
                              child: MyButton(
                                onTap: () {
                                  fetchData();
                                  booktime = '';
                                },
                                hinText: 'จองคิว',
                                color: Color.fromARGB(255, 82, 255, 67),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              child: MyButton(
                                onTap: () {
                                  cancel = 'cancel';
                                  fetchData();
                                  cancel = '';
                                },
                                hinText: 'ยกเลิกคิว',
                                color: Color.fromARGB(255, 255, 95, 95),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: 550,
            child: Container(
              width: 300,
              child: MyButton(
                onTap: () {
                  admininsert = 'yes';
                  print(admininsert);
                  fetchData();
                  admininsert = '';
                },
                hinText: 'เพิ่มคิวนัดหมาย',
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
