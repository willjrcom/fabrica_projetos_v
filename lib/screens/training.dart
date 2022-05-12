import 'package:flutter/material.dart';
import 'package:my_app/Model/profile_instance.dart';

import '../Model/training_instance.dart';
import '../database/profile_database.dart';
import '../database/training_database.dart';

enum selectOptions { lafayette, jefferson }

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late ProfileInstance profile;
  selectOptions? _character = selectOptions.lafayette;

  void loadProfile(newProfile) {
    if (newProfile != null) {
      profile = newProfile;
    }
  }

  @override
  Widget build(BuildContext context) {
    //findProfileById().then((profile) => setState(() => loadProfile(profile)));
    //findAllTraining().then((list) => print(list));

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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => finishTraining().then((training) => Navigator.pop(context, training)),
        icon: const Icon(Icons.check, color: Colors.black),
        label: const Text('Finalizar treino', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
