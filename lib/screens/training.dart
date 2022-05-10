import 'package:flutter/material.dart';
import 'package:my_app/Model/profile_instance.dart';

import '../database/app_database.dart';

enum selectOptions { lafayette, jefferson }

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late ProfileInstance profile;

  bool userExists = false;
  selectOptions? _character = selectOptions.lafayette;

  void loadProfile(newProfile) {
    userExists = true;
    profile = newProfile;
  }

  @override
  Widget build(BuildContext context) {

    findById().then((profile) => setState(() => loadProfile(profile)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo treino', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              title: Text('1. Escolha uma opção abaixo!'),
            ),
            Row(
              children: [
                Expanded(
                    child: Radio<selectOptions>(
                        value: selectOptions.lafayette,
                        groupValue: _character,
                        onChanged: (selectOptions? value) {
                          setState(() {
                            _character = value!;
                          });
                        }
                    ),
                ),
                Expanded(
                  child: Radio<selectOptions>(
                      value: selectOptions.jefferson,
                      groupValue: _character,
                      onChanged: (selectOptions? value) {
                        setState(() {
                          _character = value!;
                        });
                      }
                  ),
                ),
              ],
            ),
            const ListTile(
              title: Text('2. Escolha uma opção abaixo!'),
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, profile),
                child: const Text('Iniciar treino')
            ),
          ],
        ),
      ),
    );
  }
}
