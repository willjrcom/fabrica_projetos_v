import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Model/exercise_instance.dart';
import 'package:my_app/Model/profile_instance.dart';
import 'package:my_app/Model/training_instance.dart';
import '../database/training_database.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late ProfileInstance profile;
  late TrainingInstance training;
  late ExerciseInstance exercises = ExerciseInstance(0, 0, 'Carregando...', 0, "");
  late int totalTime = 0;
  late String totalTrainingTime = "0";

  void loadProfile(newProfile) {
    if (newProfile != null) {
      setState(() => profile = newProfile);
    }
  }

  void loadOpenTraining(newTraining) {
    if (newTraining != null) {
      format(Duration d) => d.toString().substring(2, 7);
      setState(() => training = newTraining);

      DateTime dataTimeStart = DateTime.parse(training.dataTimeStart);
      Duration timeDifferenceNow = DateTime.now().difference(dataTimeStart);
      totalTrainingTime = format(timeDifferenceNow);

      ExerciseInstance exercise = exerciseFromMap(jsonDecode(training.exercises));
      setState(() => exercises = exercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    findOpenTraining().then((value) => loadOpenTraining(value));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo treino',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Treino gerado:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/paper.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: ListTile(
                      title: Text(exercises.description
                          .replaceAll("Aquecimento: ", "Aquecimento:\n")
                          .replaceAll("--Treino: ", "\nTreino:\n") + "\n",
                        style: const TextStyle(fontSize: 20, height: 3, letterSpacing: 1, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10,
                              leading: Icon(Icons.pause_circle_filled, color: Colors.red[700],),
                              title: Text("Max: " + exercises.totalTime.toString() + " min")
                            )
                          ),
                          Card(
                              child: ListTile(
                                  minLeadingWidth: 10,
                                  leading: const Icon(Icons.timer, color: Colors.black),
                                  title: Text(totalTrainingTime + " min")
                              )
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Column(
                          children: const [
                            ListTile(
                              minLeadingWidth: 10,
                              leading: Icon(Icons.circle, color: Colors.blue),
                              title: Text("CA: Caminhar")
                            ),
                            ListTile(
                                minLeadingWidth: 10,
                                leading: Icon(Icons.circle, color: Colors.green),
                                title: Text("CO: Correr")
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => finishTraining()
            .then((training) => Navigator.pop(context, training)),
        icon: const Icon(Icons.check, color: Colors.black),
        label: const Text('Finalizar treino',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
