import 'package:agencia_la/colors.dart';
import 'package:flutter/material.dart';
import 'package:agencia_la/screens/client_profile_screen.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({super.key});

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Pedidos',
    ),
    Text(
      'Solicitar uma Lanny',
    ),
    ClientProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Solicite uma Lanny',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AgenciaLaColors.darkPrimary,
        unselectedItemColor: AgenciaLaColors.unselectedIcon,
        backgroundColor: AgenciaLaColors.background,
        elevation: 10,
        iconSize: 32,
        onTap: _onItemTapped,
      ),
    );
  }
}
