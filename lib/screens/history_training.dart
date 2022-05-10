import 'package:flutter/material.dart';

class HistoryTrainingScreen extends StatelessWidget {
  const HistoryTrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: Icon(Icons.directions_run),
                              title: Text('Treino 1'),
                              trailing: Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: Icon(Icons.directions_run),
                              title: Text('Treino 2'),
                              trailing: Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: Icon(Icons.directions_run),
                              title: Text('Treino 3'),
                              trailing: Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: Icon(Icons.directions_run),
                              title: Text('Treino 4'),
                              trailing: Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minLeadingWidth: 10.0,
                              leading: Icon(Icons.directions_run),
                              title: Text('Treino 5'),
                              trailing: Icon(Icons.more_horiz),
                              onTap: onTabTapped,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
