import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormModel extends StatelessWidget {
  TextFormModel({
    this.titlecontroller,
    this.validation,
    this.onchange,
    this.keybordtype,
    this.ontapped,
    this.IsClicked,
    this.label,
    this.data,
  });
  TextEditingController? titlecontroller;
  String? Function(String?)? validation;
  void Function(String)? onchange;
  TextInputType? keybordtype;
  void Function()? ontapped;
  bool? IsClicked;
  String? label;
  String? data;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: data,
          fillColor: Colors.white30),
      enabled: IsClicked,
      onTap: ontapped,
      onChanged: onchange,
      controller: titlecontroller,
      keyboardType: keybordtype,
      validator: validation,
    );
  }
}
