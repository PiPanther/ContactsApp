import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const MyTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
      child: SizedBox(
        child: TextFormField(
          keyboardType: keyboardType,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white38),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: text,
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
      ),
    );
  }
}
