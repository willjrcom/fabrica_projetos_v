
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icone;
  final String? titulo;
  final String? placeholder;
  TextInputType? tipoCampo = TextInputType.text;

  InputField(
      {Key? key, this.controller,
        this.titulo,
        this.placeholder,
        this.icone,
        this.tipoCampo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: titulo,
          hintText: placeholder,
        ),
        keyboardType: tipoCampo,
      ),
    );
  }
}
