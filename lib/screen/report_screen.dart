import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/widgets/background_widget.dart';
import 'package:http/http.dart' as http;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List data = [];
  List petdata = [];

  TextEditingController name = TextEditingController();
  TextEditingController id_pet = TextEditingController();

  TextEditingController symptom = TextEditingController();
  TextEditingController treatment = TextEditingController();

  TextEditingController pet_name = TextEditingController();
  TextEditingController species = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController weight = TextEditingController();

  Future<void> getrecord() async {
    String nametext = name.text;
    String uri = "http://127.0.0.1/php_api/view_pet.php?owner_name=$nametext";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        data = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> get_history_record() async {
    String idpet = id_pet.text;
    String uri = "http://127.0.0.1/php_api/view_pet_data.php?idpet=$idpet";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        petdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addhistory() async {
    String uri = "http://127.0.0.1/php_api/add_pet_history.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "idpet": id_pet.text,
        "symptom": symptom.text,
        "treatment": treatment.text
      });
      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "invalid") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addpet() async {
    String uri = "http://127.0.0.1/php_api/add_pet.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "pet_name": pet_name.text,
        "ownername": name.text,
        "species": species.text,
        "breed": breed.text,
        "birthdate": birthdate.text,
        "weight": weight.text,
      });
      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "already") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "invalid") {
        _showMyDialog(response['message']);
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Report')),
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
              top: 40,
              left: 1000,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: 600,
                height: 860,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'รายชื่อสัตว์เลี้ยง',
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            width: 200,
                            child: MyButton(
                              onTap: () {
                                print(name.text);
                                getrecord();
                              },
                              hinText: 'ค้นหา',
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('ชื่อลูกค้า'),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 180,
            left: 1000,
            child: Container(
              width: 600,
              height: 340,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('ID : ' +
                          data[index]['pet_id'] +
                          '\nชื่อ : ' +
                          data[index]['pet_name'] +
                          '\nสายพันธุ์ : ' +
                          data[index]['species'] +
                          '\nน้ำหนัก : ' +
                          data[index]['weight']),
                      subtitle: Text('เจ้าของ คุณ' + data[index]['owner_name']),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 550,
            left: 1000,
            child: Container(
              width: 600,
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('ลงทะเบียนสัตว์เลี้ยง **กรณียังไม่ได้ลงทะเบียน',
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: pet_name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('ชื่อสัตว์เลี้ยง'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('ชื่อเจ้าของ'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: species,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('ชนิด (*เช่น สุนัข,แมว)'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: breed,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('สายพันธุ์'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: birthdate,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('วันเกิด (yyyy-mm-dd)'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: weight,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('น้ำหนัก (*เช่น 1kg)'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 200,
                      child: MyButton(
                        onTap: () {
                          // print(pet_name.text);
                          // print(name.text);
                          // print(species.text);
                          // print(breed.text);
                          // print(birthdate.text);
                          // print(weight.text);
                          addpet();
                        },
                        hinText: 'ลงทะเบียน',
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 130,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: 800,
                height: 480,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('ประวัติการรักษา',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 230,
                          ),
                          Container(
                            width: 200,
                            child: MyButton(
                              onTap: () {
                                print(id_pet.text);
                                get_history_record();
                              },
                              hinText: 'ค้นหา',
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 50,
            left: 280,
            child: Container(
              width: 200,
              child: TextFormField(
                controller: id_pet,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('รหัสสัตว์เลี้ยง'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 150,
            child: Container(
              width: 750,
              height: 380,
              child: ListView.builder(
                itemCount: petdata.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('อาการ : ' +
                          petdata[index]['symptom'] +
                          '\nประวัติการรักษา : ' +
                          petdata[index]['treatment_history']),
                      subtitle: Text('วันเวลาที่ได้รับการรักษา : ' +
                          petdata[index]['date_of_treatment']),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: 550,
              left: 130,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: 800,
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('กรอกรายงานการรักษา',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: id_pet,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('รหัสสัตว์เลี้ยง'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: symptom,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('อาการ'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: treatment,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('การรักษา'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        child: MyButton(
                          onTap: () {
                            addhistory();
                            get_history_record();
                          },
                          hinText: 'กรอกข้อมูล',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
