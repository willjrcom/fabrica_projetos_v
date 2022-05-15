import 'package:flutter/material.dart';
import 'package:my_app/Model/training_instance.dart';

import '../database/training_database.dart';

class HistoryTrainingScreen extends StatefulWidget {
  HistoryTrainingScreen({Key? key}) : super(key: key);
  final List<TrainingInstance> _trainings = [];

  @override
  State<HistoryTrainingScreen> createState() => _HistoryTrainingScreenState();
}

class _HistoryTrainingScreenState extends State<HistoryTrainingScreen> {
  @override
  Widget build(BuildContext context) {

    void loadAllTraining(trainings) {
      print(trainings.length);
      if (widget._trainings.length != trainings.length) {
        for (TrainingInstance training in trainings) {
            widget._trainings.add(training);
          }
      }
    }
    findAllTrainingComplete().then((value) => loadAllTraining(value));

    void onTabTapped() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scaffold(
                body: Column(
                  children: [
                    const Text('Treino',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      ),
                    ),
                    const Card(
                        child: ListTile(
                          leading: Icon(Icons.timelapse),
                          title: Text('${20} min'),
                        )
                    ),
                    Card(
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('Exercícios praticados',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 190,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    children: const [
                                      Card(
                                        child: ListTile(
                                          title: Text('Aquecimento'),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Caminhada'),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Corrida'),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Caminhada'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),

                floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black),
                  backgroundColor: Colors.yellow,
                ),
              ),
            ),
          );
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                const ListTile(
                  minLeadingWidth: 10.0,
                  leading: Icon(Icons.history),
                  title: Text('Histórico de treinos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: widget._trainings.length,
                      itemBuilder: (context, indice) {
                        return Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: const Icon(Icons.directions_run),
                              title: Text(widget._trainings[indice].name),
                              trailing: const Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

funcao() {
  return Column(
      children: const [
        Card(
          child: ListTile(
            minLeadingWidth: 10.0,
            leading: Icon(Icons.directions_run),
            title: Text('Treino 1'),
            trailing: Icon(Icons.more_horiz),
            //onTap: onTabTapped,
          ),
        ),
      ],
    );
}