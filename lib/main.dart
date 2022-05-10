import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'screens/home.dart';
import 'screens/training.dart';
import 'screens/profile.dart';

void main() => runApp(const VncApp());

class VncApp extends StatelessWidget {
  const VncApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '# vc na corrida',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: Colors.yellow,
        ),
      ),
      home: const ControlScreen(),
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
    const HomeScreen(),
    const TrainingScreen(),
    const ProfileScreen()
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