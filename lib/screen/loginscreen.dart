import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/component/mytextfield.dart';
import 'package:vet_desktop/screen/main_view.dart';
import 'package:vet_desktop/screen/main_view_manager.dart';
import 'package:vet_desktop/screen/main_view_doctor.dart';
import 'package:vet_desktop/widgets/background_widget.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernamecontroller = TextEditingController();
  final passcontroller = TextEditingController();

  Future login() async {
    try {
      String uri = 'https://setest123.000webhostapp.com/php_api/verify.php';
      var res = await http.post(Uri.parse(uri), body: {
        "username": usernamecontroller.text,
        "password": passcontroller.text,
      });

      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        if (response["role"] == "admin") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainView()));
        } else if (response["role"] == "doctor") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainViewDoctor()));
        } else if (response["role"] == "manager") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainViewManager()));
        } else {
          _showMyDialog('สมาชิกโปรด login ผ่านโทรศัพท์มือถือ');
        }
      } else if (response["status"] == "no_match_pass") {
        _showMyDialog(response['message']);
        print(response['message']);
      } else if (response["status"] == "no_username") {
        _showMyDialog(response['message']);
        print(response['message']);
      } else if (response["status"] == "fill_in_blank") {
        _showMyDialog(response['message']);
        print(response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  void _showMyDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 228, 180, 118),
          title: const Text('status'),
          content: Text(txtMsg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const background(),
          Positioned(
            top: 300,
            left: 500,
            right: 500,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(160, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: 500,
              height: 300,
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFiled(
                      controller: usernamecontroller,
                      hintText: 'Enter your Username.',
                      obscureText: false,
                      labelText: 'Username',
                      icon: Icon(Icons.email_outlined),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextFiled(
                        controller: passcontroller,
                        hintText: 'Enter your password.',
                        obscureText: true,
                        labelText: 'Password',
                        icon: Icon(Icons.lock_outline_rounded)),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                        onTap: () {
                          login();
                        },
                        hinText: 'เข้าสู่ระบบ',
                        color: Color.fromARGB(255, 187, 166, 159)),
                    const SizedBox(
                      height: 40,
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
