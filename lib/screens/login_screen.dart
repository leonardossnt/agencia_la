import 'package:agencia_la/auth/auth.dart';
import 'package:agencia_la/colors.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:agencia_la/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AgenciaLaColors.background,
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  SizedBox(height: 18),
                  ScreenTitle(),
                  SizedBox(height: 84),
                  Logo(),
                  SizedBox(height: 48),
                  LoginForm(),
                  SizedBox(height: 48),
                  SignUpText(),
                  SizedBox(height: 60)
                ],
              )
          )
      )
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Bem vindo!",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AgenciaLaColors.darkPrimary
                )
            )
        )
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 84),
      child: Image.asset('assets/images/agenciala.png')
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isPasswordObscured = true;

  Future login() async {
    String login = _login.text;
    String password = _password.text;

    User? user = await Auth.signInUsingEmailPassword(
        email: login, password: password);

    if (user != null) {
      print('User found! Proceed to sign in');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ClientMainScreen()
        ),
      );

    } else {
      // TODO: show error message
      print('User not found!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _login,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AgenciaLaColors.inputBackground,
                  ),
                  borderRadius: BorderRadius.circular(24)),
              filled: true,
              fillColor: AgenciaLaColors.inputBackground,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _password,
            keyboardType: TextInputType.text,
            obscureText: _isPasswordObscured,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'senha',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordObscured
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                  },
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: AgenciaLaColors.inputBackground,
                  ),
                  borderRadius: BorderRadius.circular(24)),
              filled: true,
              fillColor: AgenciaLaColors.inputBackground,
            ),
          ),
          const SizedBox(height: 16),
          LoginButton(login: login),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({required this.login, super.key});
  final Function login;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isAuthenticating = false;

  void login() async {
    setState(() {
      isAuthenticating = true;
    });
    await widget.login();
    setState(() {
      isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isAuthenticating ? null : login,
      style: ElevatedButton.styleFrom(
        backgroundColor: AgenciaLaColors.primary,
        foregroundColor: AgenciaLaColors.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: isAuthenticating ?
      const CircularProgressIndicator() :
      const Text(
        "Entrar",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Ainda não possui conta? ',
              style: const TextStyle(
                color: AgenciaLaColors.onBackground,
                fontSize: 16,
              ),
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen()
                        ),
                      ),
                    },
                    child: const Text(
                      "Cadastre-se",
                      style: TextStyle(
                        color: AgenciaLaColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
