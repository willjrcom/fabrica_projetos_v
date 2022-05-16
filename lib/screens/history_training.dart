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

  String loadTime(TrainingInstance training, String time) {
    print(training);
    DateTime timeStart = DateTime.parse(training.dataTimeStart);

    if (time == 'total') {
      return DateTime.now().difference(timeStart).inMinutes.toString();
    } else if (time == 'start') {
      String hour = timeStart.hour < 10 ? '0' + timeStart.hour.toString() : timeStart.hour.toString();
      String minute = timeStart.minute < 10 ? '0' + timeStart.minute.toString() : timeStart.minute.toString();
      return hour + ':' + minute;
    }
    // final
    DateTime timeFinish = DateTime.parse(training.dataTimeStart); //dataTimeFinish
    String hour = timeFinish.hour < 10 ? '0' + timeFinish.hour.toString() : timeFinish.hour.toString();
    String minute = timeFinish.minute < 10 ? '0' + timeFinish.minute.toString() : timeFinish.minute.toString();
    return hour + ':' + minute;
  }

  @override
  Widget build(BuildContext context) {
    void loadAllTraining(trainings) {
      if (trainings.length == 0) {
        widget._trainings.clear();
      }
      for (TrainingInstance training in trainings) {
        final index = widget._trainings
            .indexWhere((element) => element.id == training.id);
        if (index == -1) {
          widget._trainings.add(training);
        }
      }
    }

    findAllTrainingComplete().then((value) => loadAllTraining(value));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget._trainings.isNotEmpty)
          Card(
            child: Column(
              children: [
                const ListTile(
                  minLeadingWidth: 10.0,
                  leading: Icon(Icons.history),
                  title: Text('Histórico de treinos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: widget._trainings.length,
                      itemBuilder: (context, indexTraining) {
                        return Card(
                          child: ListTile(
                            minLeadingWidth: 10.0,
                            leading: const Icon(Icons.directions_run),
                            title: Text(widget._trainings[indexTraining].name),
                            trailing: const Icon(Icons.more_horiz),
                            onTap: () => {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Scaffold(
                                        body: Column(
                                          children: [
                                            const Text(
                                              'Treino',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            Card(
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      leading: const Icon(Icons.timelapse),
                                                      title: Text('Total: ${loadTime(widget._trainings[indexTraining], 'total')} min'),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(Icons.timelapse),
                                                      title: Text('Início: ${loadTime(widget._trainings[indexTraining], 'start')} min'),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(Icons.timelapse),
                                                      title: Text('Final: ${loadTime(widget._trainings[indexTraining], '')} min'),
                                                    ),
                                                  ],
                                                )),
                                            if (widget._trainings[indexTraining].exercises.isNotEmpty)
                                            Card(
                                                child: Column(
                                                children: [
                                                  const ListTile(
                                                    title: Text(
                                                      'Exercícios praticados',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                    ListView.builder(
                                                    itemCount: widget._trainings[indexTraining].exercises.length,
                                                    itemBuilder: (context, indexExercises) {
                                                      return
                                                        Card(
                                                          child: ListTile(
                                                            title: Text(widget._trainings[indexTraining].exercises[indexExercises]),
                                                          ),
                                                        );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        floatingActionButton:
                                            FloatingActionButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Icon(Icons.close,
                                              color: Colors.black),
                                          backgroundColor: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            },
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
