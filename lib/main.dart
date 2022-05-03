import 'package:flutter/material.dart';

void main() => runApp(const VncApp());

class VncApp extends StatelessWidget {
  const VncApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '# vc na corrida',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.yellow,
        ),
      ),
      home: const Home(),
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

class Cadastro {
  late final String nome;
  late final int idade;

  Cadastro(this.nome, this.idade);

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
        title: const LogoTitle(),
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
      final cadastro = Cadastro(nome, idade);
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaCadastrosState();
  }
}

class ListaCadastrosState extends State<Home> {
  final List<Cadastro> _cadastros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoTitle(),
      ),
      body: ListView.builder(
          itemCount: _cadastros.length,
          itemBuilder: (context, indice) {
            return ListTile(
              title: Text(_cadastros[indice].nome),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final Future<Cadastro?> future =
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
        icon: const Icon(Icons.add),
        label: const Text('Cadastro'),
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
