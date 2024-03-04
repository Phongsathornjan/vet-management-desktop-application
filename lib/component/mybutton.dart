import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.hinText,
    required this.color,
  });

  final Function()? onTap;
  final String hinText;
  final color;

  signIn() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: color,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 0.5,
            ),
            vertical: BorderSide(
              color: const Color.fromARGB(255, 0, 0, 0),
              width: 0.5,
            ),
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Center(
          child: Text(
            hinText,
            style: GoogleFonts.notoSansThai(
                fontSize: 16,
                color: Colors.black,
                textStyle: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      ),
    );
  }
}
