import 'package:flutter/material.dart';

void main() => runApp(const VncApp());

class VncApp extends StatelessWidget {
  const VncApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '# vc na corrida',
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.yellow,
        ),
      ),
      home: const ControlScreen(),
    );
  }
}

class LogoTitle extends StatelessWidget {
  const LogoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: const [
          Text(
            '#',
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'VC NA',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'CORRIDA',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    HomeScreen(),
    TreinoScreen(),
    PerfilScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoTitle(),
      ),
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _indiceAtual,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Painel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle),
            label: 'Treino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: onTabTapped,
      ),
    );
  }
}

class CadastroInstance {
  late final String nome;
  late final int idade;

  CadastroInstance(this.nome, this.idade);

  @override
  String toString() {
    return 'Cadastro{nome: $nome, idade: $idade}';
  }
}

class FormCadastro extends StatelessWidget {
  FormCadastro({Key? key}) : super(key: key);

  final TextEditingController _controllerInputNome = TextEditingController();
  final TextEditingController _controllerInputIdade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Campo(
              controller: _controllerInputNome,
              titulo: 'Nome completo',
              placeholder: 'Digite seu nome'),
          Campo(
            controller: _controllerInputIdade,
            titulo: 'Idade',
            tipoCampo: TextInputType.number,
          ),
          ElevatedButton(
              onPressed: () => _cadastrar(context),
              child: const Text('Salvar dados'))
        ],
      ),
    );
  }

  void _cadastrar(BuildContext context) {
    final String nome = _controllerInputNome.text;
    final int? idade = int.tryParse(_controllerInputIdade.text);

    if (nome != null && idade != null) {
      final cadastro = CadastroInstance(nome, idade);
      Navigator.pop(context, cadastro);
    }
  }
}

class Campo extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icone;
  final String? titulo;
  final String? placeholder;
  TextInputType? tipoCampo = TextInputType.text;

  Campo(
      {Key? key, this.controller,
      this.titulo,
      this.placeholder,
      this.icone,
      this.tipoCampo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: titulo,
          hintText: placeholder,
        ),
        keyboardType: tipoCampo,
      ),
    );
  }
}

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
          )
        ],
      ),
    );
  }
}

class TreinoScreen extends StatelessWidget {
  const TreinoScreen({Key? key}) : super(key: key);

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

class PerfilScreen extends StatefulWidget {

  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PerfilState();
  }
}

class PerfilState extends State<PerfilScreen> {
  final List<CadastroInstance> _cadastros = [];

  @override
  Widget build(BuildContext context) {
    double _currentSliderValue = 20;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      minLeadingWidth: 10.0,
                      title: Text('William Alfred Gazal Júnior'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    child: ListTile(
                      minLeadingWidth: 10.0,
                      leading: Icon(Icons.male),
                      title: Text('M'),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      minLeadingWidth: 10.0,
                      title: Text('IMC:  ${_currentSliderValue.round().toString()}'),
                    ),
                  ),
                Expanded(
                  child: Slider(
                    max: 100,
                    divisions: 5,
                    thumbColor: Colors.blue,
                    activeColor: Colors.red,
                    inactiveColor: Colors.red[100],
                    value: _currentSliderValue,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final Future<CadastroInstance?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormCadastro();
          }));
          future.then((cadastro) {
            debugPrint(cadastro.toString());
            if (cadastro != null) {
              _cadastros.add(cadastro);
            }
          });
        },
        icon: const Icon(Icons.edit, color: Colors.black),
        label: const Text('Cadastro', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}

class Corrida extends StatelessWidget {
  final String titulo;
  final String texto;

  const Corrida(this.titulo, this.texto);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text(titulo),
        subtitle: Text(texto),
      ),
    );
  }
}
