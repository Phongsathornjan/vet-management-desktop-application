import 'package:flutter/material.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/component/mytextfield.dart';
import 'package:vet_desktop/widgets/background_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  final namecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final birthcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const background(),
          Positioned(
            top: 110,
            left: 300,
            right: 300,
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
                                'ลงทะเบียน',
                                style: GoogleFonts.notoSansThai(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                    color: Color.fromARGB(255, 90, 90, 90)),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'กรอกข้อมูลเพื่อสมัครสมาชิก',
                                style: GoogleFonts.notoSansThai(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    color: Color.fromARGB(255, 90, 90, 90)),
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
                    controller: emailcontroller,
                    hintText: 'Enter Email.',
                    obscureText: false,
                    labelText: 'Email',
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
                      controller: birthcontroller,
                      hintText: 'Enter Birthday.',
                      obscureText: false,
                      labelText: 'Birthday',
                      icon: Icon(Icons.cake_outlined)),
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
                      onTap: () {},
                      hinText: 'สมัครสมาชิก',
                      color: Color.fromARGB(255, 187, 166, 159)),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
