import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Model/exercise_instance.dart';
import 'package:my_app/Model/training_instance.dart';

import '../database/training_database.dart';

class HistoryTrainingScreen extends StatefulWidget {
  HistoryTrainingScreen({Key? key}) : super(key: key);
  final List<TrainingInstance> _trainings = [];

  @override
  State<HistoryTrainingScreen> createState() => _HistoryTrainingScreenState();
}

class _HistoryTrainingScreenState extends State<HistoryTrainingScreen> {
  void loadAllTraining(trainings) {
    if (trainings.length == 0) {
      widget._trainings.clear();
    }
    for (TrainingInstance training in trainings) {
      final index = widget._trainings
          .indexWhere((element) => element.id == training.id);
      if (index == -1) {
        setState(() => widget._trainings.add(training));
      }
    }
  }

  ExerciseInstance getExercise(text) {
    return exerciseFromMap(jsonDecode(text));
  }

  String loadTime(TrainingInstance training, String time) {
    DateTime timeStart = DateTime.parse(training.dataTimeStart);
    DateTime timeFinish = DateTime.parse(training.dataTimeFinish);

    if (time == 'total') {
      return timeFinish.difference(timeStart).inMinutes.toString();
    } else if (time == 'start') {
      String hour = timeStart.hour < 10 ? '0' + timeStart.hour.toString() : timeStart.hour.toString();
      String minute = timeStart.minute < 10 ? '0' + timeStart.minute.toString() : timeStart.minute.toString();
      return hour + ':' + minute;
    }
    // final
    String hour = timeFinish.hour < 10 ? '0' + timeFinish.hour.toString() : timeFinish.hour.toString();
    String minute = timeFinish.minute < 10 ? '0' + timeFinish.minute.toString() : timeFinish.minute.toString();
    return hour + ':' + minute;
  }

  String getDateTraining(training) {
    DateTime dateTimeStart = DateTime.parse(training.dataTimeStart);
    return DateFormat('EEEE - dd/MM').format(dateTimeStart)
        .replaceAll("Monday", "Segunda")
        .replaceAll("Tuesday", "Terça")
        .replaceAll("Wednesday ", "Quarta")
        .replaceAll("Thursday", "Quinta")
        .replaceAll("Friday", "Sexta")
        .replaceAll("Saturday", "Sabado")
        .replaceAll("Sunday", "Domingo");
  }

  String getHourTraining(training) {
    DateTime dateTimeStart = DateTime.parse(training.dataTimeStart);
    return DateFormat('EEEE - hh:mm').format(dateTimeStart)
        .replaceAll("Monday", "Segunda")
        .replaceAll("Tuesday", "Terça")
        .replaceAll("Wednesday ", "Quarta")
        .replaceAll("Thursday", "Quinta")
        .replaceAll("Friday", "Sexta")
        .replaceAll("Saturday", "Sabado")
        .replaceAll("Sunday", "Domingo");
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 300,
                  child: ListView.builder(
                    itemCount: widget._trainings.length,
                    itemBuilder: (context, indexTraining) {
                      return Card(
                        child: ListTile(
                          minLeadingWidth: 10.0,
                          leading: const Icon(Icons.date_range_outlined),
                          title: Text(getDateTraining(widget._trainings[indexTraining])),
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
                                          Text(
                                            getHourTraining(widget._trainings[indexTraining]),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          Column(
                                            children: [
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
                                                ),
                                              ),
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
                                                    ListTile(
                                                      title: Text(getExercise(widget._trainings[indexTraining].exercises).description
                                                          .replaceAll("--Treino: ", "\nTreino:\n")
                                                          .replaceAll("Aquecimento: ", "Aquecimento:\n")),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
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
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}