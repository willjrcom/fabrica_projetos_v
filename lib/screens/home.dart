import 'package:flutter/material.dart';
import 'package:my_app/Model/profile_instance.dart';

import '../Model/training_instance.dart';
import '../components/carousel.dart';
import '../database/profile_database.dart';
import '../database/training_database.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProfileInstance profile;
  late TrainingInstance training;

  late String dataTimeStart;
  late String dataTimeTotal = '0';
  bool userExists = false;
  bool hasOpenTraining = false;
  int totalTrainingFinish = 0;

  void loadProfile(newProfile) {
    if (newProfile != null) {
      userExists = true;
      profile = newProfile;
      countTraining().then((value) => totalTrainingFinish = value);
    }
  }

  void loadOpenTraining(newTraining) {
    if (newTraining != null) {
      training = newTraining;

      DateTime timeStart = DateTime.parse(training.dataTimeStart);
      dataTimeTotal = DateTime.now().difference(timeStart).inMinutes.toString();
      String hour = timeStart.hour < 10 ? '0' + timeStart.hour.toString() : timeStart.hour.toString();
      String minute = timeStart.minute < 10 ? '0' + timeStart.minute.toString() : timeStart.minute.toString();
      dataTimeStart = hour + ':' + minute;

      if (newTraining.isOpen == 1) {
        setState(() => hasOpenTraining = true);
      } else {
        setState(() => hasOpenTraining = false);
      }
    }
  }

  void onFinishTraining() {
    countTraining().then((value) => setState(() => totalTrainingFinish = value));
    setState(() => hasOpenTraining = false);
  }

  onTapTraining() {
    loadScreen(context, 'training').then((trainingFinish) => {
      if (trainingFinish?.isOpen == 0) {
        onFinishTraining()
      } else {
        findOpenTraining().then((value) => loadOpenTraining(value))
      }
    });
  }

  onPressFloatingActionButton() {
    if (userExists) {
      training = TrainingInstance(0, 'treino 1', '', '', '', 1, []);
      createTraining(training).then((value) => loadScreen(context, 'training').then((trainingFinish) => {
        if (trainingFinish?.isOpen == 0) {
          onFinishTraining()
        } else {
          findOpenTraining().then((value) => loadOpenTraining(value))
        }
      })
      );
    } else {
      loadScreen(context, 'register').then((newProfile) => newProfile != null ? loadProfile(newProfile) : null);
    }

  }

  @override
  Widget build(BuildContext context) {
    if (!userExists) {
      findProfileById().then((profile) => setState(() => loadProfile(profile)));
    } else {
      findOpenTraining().then((value) => loadOpenTraining(value));
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: userExists
                    ? Text('Seja bem vindo, ${profile.name.split(' ')[0]}')
                    : const Text('Seja bem vindo!'),
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          const ListTile(
                            title: Text('Treinos concluídos', textAlign: TextAlign.center),
                          ),
                          ListTile(
                            title: Text(totalTrainingFinish.toString(), textAlign: TextAlign.center),
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
              if (hasOpenTraining)
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8, top: 16),
                      child:
                      ListTile(
                        title: Text('Treino em andamento', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Material(
                      child: InkWell(
                        onTap: () => onTapTraining(),
                        child: Card(
                          child: Column(
                            children: [
                              const ListTile(
                                minLeadingWidth: 10.0,
                                title: Text('Acessar treino', style: TextStyle(fontSize: 20),),
                                leading: Icon(Icons.directions_run),
                                trailing: Icon(Icons.exit_to_app, size: 30,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      minLeadingWidth: 10.0,
                                      title: Text('Início: ' + dataTimeStart),
                                      leading: const Icon(Icons.play_arrow),
                                    ),
                                    ListTile(
                                      minLeadingWidth: 10.0,
                                      title: Text('Total: ' + dataTimeTotal + ' min'),
                                      leading: const Icon(Icons.timer),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Column(
                children: const [
                  CarouselTips(),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: !hasOpenTraining ? FloatingActionButton.extended(
        onPressed: () => onPressFloatingActionButton(),
        icon: Icon(userExists ? Icons.play_arrow : Icons.add, color: Colors.black),
        label: Text(userExists ? 'Gerar treino' : 'Cadastrar perfil', style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ) : null,
    );
  }
}