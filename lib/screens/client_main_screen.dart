import 'package:agencia_la/colors.dart';
import 'package:agencia_la/screens/client_edit_profile.dart';
import 'package:agencia_la/screens/client_orders_screen.dart';
import 'package:agencia_la/screens/login_screen.dart';
import 'package:agencia_la/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:agencia_la/screens/client_profile_screen.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({super.key});
  static const routeName = '/clientMainScreen';


  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  int _selectedIndex = 0;
  Widget page = const ClientOrdersScreen();

  static const List<Widget> _widgetOptions = <Widget>[
    ClientOrdersScreen(),
    ClientMakeOrder(),
    ClientProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      page = _widgetOptions[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
          if (settings.name == ClientMakeOrder.routeName) {
            page = const ClientMakeOrder();
          } else if (settings.name == ClientProfileScreen.routeName) {
            page = const ClientProfileScreen();
          } else if (settings.name == ClientEditProfileScreen.routeName) {
            page = const ClientEditProfileScreen();
          } else if (settings.name == LoginScreen.routeName) {
            page = const LoginScreen();
          } else if (settings.name == SignUpScreen.routeName) {
            page = const SignUpScreen();
          } else if (settings.name == ClientOrdersScreen.routeName) {
            page = const ClientOrdersScreen();
          }

          return MaterialPageRoute(builder: (_) => page);
        },
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

class ClientMakeOrder extends StatelessWidget {
  const ClientMakeOrder({Key? key}) : super(key: key);
  static const routeName = '/clientMakeOrder';


  @override
  Widget build(BuildContext context) {
    return const Text('Solicitar uma Lanny');
  }
}
