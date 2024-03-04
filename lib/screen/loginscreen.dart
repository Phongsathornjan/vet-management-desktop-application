import 'package:flutter/material.dart';
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/component/mytextfield.dart';
import 'package:vet_desktop/screen/main_view.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

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
                      controller: emailcontroller,
                      hintText: 'Enter your email.',
                      obscureText: false,
                      labelText: 'Email',
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainView()));
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
