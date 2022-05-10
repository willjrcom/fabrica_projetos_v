import 'package:flutter/material.dart';
import 'package:my_app/Model/profile_instance.dart';

import '../database/app_database.dart';
import 'register.dart';
import 'training.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProfileInstance profile;

  bool userExists = false;

  void loadProfile(newProfile) {
    userExists = true;
    profile = newProfile;
  }

  @override
  Widget build(BuildContext context) {
    findById().then((profile) => {
      setState(() => {
        loadProfile(profile)
      }),
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              title: Text('Seja bem vindo, William!'),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: const [
                        ListTile(
                          title: Text('Treinos concluídos', textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text('8', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: const [
                        ListTile(
                          title: Text('KM', textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text('261', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: const [
                        ListTile(
                          title: Text('Passos', textAlign: TextAlign.center),
                        ),
                        ListTile(
                          title: Text('60.843', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final Future<ProfileInstance?> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return userExists ? const TrainingScreen() : const RegisterScreen();
          }));
          future.then((newProfile) {
            if (newProfile != null) {
              loadProfile(newProfile);
            }
          });
        },
        icon: Icon(userExists ? Icons.play_arrow : Icons.add, color: Colors.black),
        label: Text(userExists ? 'Iniciar treino' : 'Cadastrar perfil', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
