
import 'package:flutter/material.dart';

import '../Model/profile_instance.dart';
import '../database/app_database.dart';
import 'register.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<ProfileScreen> {
  bool userExists = false;
  late String? name = '';
  late int? age = 0;
  late double weight = 0;
  late double height = 0;
  double imc = 0;

  void loadProfile(profile) {
    userExists = true;
    name = profile.name;
    age = profile.age;
    weight = profile.weight;
    height = profile.height;

    imc = profile.weight / ((profile.height / 100) * (profile.height / 100));

    if (imc > 50) {
      imc = 50;
    }
  }

  MaterialColor validateImcColorActive() {
    if (imc < 18.5 || imc > 40) {
      return Colors.red;
    } else if (imc > 24.9) {
      return Colors.yellow;
    } else if (imc > 30) {
      return Colors.orange;
    }
    return Colors.green;
  }

  Color? validateImcColorInactive() {
    if (imc < 18.5 || imc > 40) {
      return Colors.red[100];
    } else if (imc > 24.9) {
      return Colors.yellow[100];
    } else if (imc > 30) {
      return Colors.orange[100];
    }
    return Colors.green[100];
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
        child: userExists
            ? Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        minLeadingWidth: 10.0,
                        title: Text(name!),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        minLeadingWidth: 10.0,
                        leading: const Icon(Icons.calendar_month),
                        title: Text(age!.toString()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Card(
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('IMC:  ${imc.toStringAsFixed(2)}'),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        max: 50,
                        min: 0,
                        divisions: 10,
                        thumbColor: Colors.blue,
                        activeColor: validateImcColorActive(),
                        inactiveColor: validateImcColorInactive(),
                        label: imc.toStringAsFixed(2),
                        onChanged: (double value) {},
                        value: imc,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.fastfood_sharp),
                        minLeadingWidth: 10.0,
                        title: Text(weight.toString() + ' kg'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        minLeadingWidth: 10.0,
                        leading: const Icon(Icons.height),
                        title: Text(height.toString() + ' cm'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
            : Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Cadastre seu perfil para iniciar!', textAlign: TextAlign.center),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      final Future<ProfileInstance?> future =
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const RegisterScreen();
                      }));
                      future.then((newProfile) {
                        if (newProfile != null) {
                          loadProfile(newProfile);
                        }
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text('Cadastrar perfil', style: TextStyle(color: Colors.black)),
                    backgroundColor: Colors.yellow,
                  ),
                ],
              ),
        ),
      ),
      floatingActionButton: userExists
          ? FloatingActionButton.extended(
            onPressed: () {
              final Future<ProfileInstance?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const RegisterScreen();
              }));
              future.then((newProfile) {
                if (newProfile != null) {
                  loadProfile(newProfile);
                }
              });
            },
            icon: const Icon(Icons.edit, color: Colors.black),
            label: const Text('Editar perfil', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ) : null,
    );
  }
}
