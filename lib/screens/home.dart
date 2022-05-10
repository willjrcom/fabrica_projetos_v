import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
