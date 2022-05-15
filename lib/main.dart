import 'package:flutter/material.dart';
import 'Model/profile_instance.dart';
import 'components/app_bar.dart';
import 'screens/home.dart';
import 'screens/history_training.dart';
import 'screens/profile.dart';
import 'screens/register.dart';
import 'screens/training.dart';

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
  int _indexScreen = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    HistoryTrainingScreen(),
    const ProfileScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _indexScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoTitle(),
      ),
      body: _screens[_indexScreen],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _indexScreen,
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

Future loadScreen(BuildContext context, String screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    if (screen == 'training') {
      return const TrainingScreen();
    } else if (screen == 'register') {
      return const RegisterScreen();
    }
    return const HomeScreen();
  }));
}