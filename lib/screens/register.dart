
import 'package:flutter/material.dart';
import 'package:my_app/components/input_field.dart';

import '../Model/profile_instance.dart';
import '../database/profile_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool userExists = false;
  final TextEditingController _controllerInputName = TextEditingController();
  final TextEditingController _controllerInputAge = TextEditingController();
  final TextEditingController _controllerInputWeight = TextEditingController();
  final TextEditingController _controllerInputHeight = TextEditingController();
  String textBtn = 'Salvar cadastro';

  void loadInputs(profile) {
    if (profile != null) {
      userExists = true;
      _controllerInputName.text = profile!.name;
      _controllerInputAge.text = profile.age.toString();
      _controllerInputWeight.text = profile!.weight.toString();
      _controllerInputHeight.text = profile!.height.toString();
      textBtn = 'Atualizar cadastro';
    }
  }
  @override
  Widget build(BuildContext context) {
    if (!userExists) {
      findProfileById().then((profile) => loadInputs(profile));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputField(
              controller: _controllerInputName,
              titulo: 'Nome completo',
              placeholder: 'Digite seu nome'),
            InputField(
              controller: _controllerInputAge,
              titulo: 'Idade',
              tipoCampo: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: _controllerInputWeight,
                    titulo: 'Peso (kg)',
                    tipoCampo: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: InputField(
                    controller: _controllerInputHeight,
                    titulo: 'Altura (cm)',
                    tipoCampo: TextInputType.number,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () => _cadastrar(context),
                child: Text(textBtn)
            ),
          ],
        ),
      ),
    );
  }

  void _cadastrar(BuildContext context) {
    const id = 1;
    final String name = _controllerInputName.text;
    final int? age = int.tryParse(_controllerInputAge.text);
    final double? weight = double.tryParse(_controllerInputWeight.text);
    final double? height = double.tryParse(_controllerInputHeight.text);

    if (name != null && age != null && weight != null && height != null) {
      final profile = ProfileInstance(id, name, age, weight, height);
      if (userExists) {
        updateProfile(profile);
      } else {
        saveProfile(profile);
      }
      Navigator.pop(context, profile);
    }
  }
}
