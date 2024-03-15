import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/component/mytextfield.dart';
import 'package:vet_desktop/widgets/background_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditUserScreen extends StatefulWidget {
  EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  List data = [];

  TextEditingController iddelete = TextEditingController();

  final usernamecontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  Future insertrecord() async {
    try {
      String uri = 'http://127.0.0.1/php_api/register_save.php';
      var res = await http.post(Uri.parse(uri), body: {
        "username": usernamecontroller.text,
        "password": passcontroller.text,
        "firstname": namecontroller.text,
        "lastname": lastnamecontroller.text,
        "phone": phonecontroller.text,
      });

      var response = jsonDecode(res.body);
      if (response["status"] == "fill_in_blank") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "success") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "already") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord(String idd) async {
    String uri = "http://127.0.0.1/php_api/view_user.php";
    if (idd != "") {
      uri = "http://127.0.0.1/php_api/view_user.php?iddelete=$idd";
    }
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        data = jsonDecode(response.body);
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
    getrecord("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'จัดการ User',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: <Widget>[
          const background(),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(126, 0, 0, 0),
            ),
            width: 2000,
            height: 2000,
          ),
          Positioned(
            top: 40,
            left: 80,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(200, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: 500,
              height: 630,
              child: Form(
                  child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'เพิ่มข้อมูล',
                                style: GoogleFonts.notoSansThai(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                    color: Color.fromARGB(255, 90, 90, 90)),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/person.png",
                          width: 34,
                          height: 34,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ข้อมูลผู้ใช้งาน',
                          style: GoogleFonts.notoSansThai(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              color: Color.fromARGB(255, 90, 90, 90)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFiled(
                    controller: usernamecontroller,
                    hintText: 'Enter Username.',
                    obscureText: false,
                    labelText: 'Username',
                    icon: Icon(Icons.email_outlined),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFiled(
                      controller: passcontroller,
                      hintText: 'Enter password.',
                      obscureText: true,
                      labelText: 'Password',
                      icon: Icon(Icons.lock_outline)),
                  const SizedBox(
                    height: 11,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/person.png",
                          width: 34,
                          height: 34,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ข้อมูลส่วนตัว',
                          style: GoogleFonts.notoSansThai(
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              color: Color.fromARGB(255, 90, 90, 90)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFiled(
                      controller: namecontroller,
                      hintText: 'Enter First Name.',
                      obscureText: false,
                      labelText: 'First Name',
                      icon: Icon(Icons.person_outline_rounded)),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFiled(
                      controller: lastnamecontroller,
                      hintText: 'Enter Last Name.',
                      obscureText: false,
                      labelText: 'Last Name',
                      icon: Icon(Icons.person_outline_rounded)),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFiled(
                      controller: phonecontroller,
                      hintText: 'Enter Your Phone Number.',
                      obscureText: false,
                      labelText: 'Phone',
                      icon: Icon(Icons.phone_android_outlined)),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                      onTap: () {
                        insertrecord();
                        getrecord("");
                      },
                      hinText: 'เพิ่มข้อมูล',
                      color: Color.fromARGB(255, 187, 166, 159)),
                ],
              )),
            ),
          ),
          Positioned(
              top: 40,
              left: 700,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(200, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                width: 900,
                height: 800,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'จัดการ ID User',
                    style: GoogleFonts.notoSansThai(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                        color: Color.fromARGB(255, 90, 90, 90)),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Positioned(
            top: 100,
            left: 700,
            child: Container(
              width: 900,
              height: 690,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('ID : ' +
                          data[index]['id'] +
                          '\nชื่อ : ' +
                          data[index]['firstname'] +
                          '\nนามสกุล : ' +
                          data[index]['lastname'] +
                          '\nUsername : ' +
                          data[index]['username']),
                      subtitle: Text('เบอร์ : ' +
                          data[index]['phone'] +
                          '\nrole : ' +
                          data[index]['role']),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 710,
            left: 80,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 500,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: iddelete,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('ใส่รหัส User ID ที่ต้องการลบ'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord(iddelete.text);
                      },
                      hinText: 'Delete',
                      color: Color.fromARGB(255, 255, 95, 95),
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
