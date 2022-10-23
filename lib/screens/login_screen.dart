import 'package:agencia_la/colors.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:agencia_la/screens/signup_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AgenciaLaColors.background,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(height: 120),
                    ScreenTitle("Bem vindo!"),
                    SizedBox(height: 84),
                    Logo(),
                    SizedBox(height: 48),
                    LoginForm(),
                    SizedBox(height: 48),
                    SignUpText(),
                    SizedBox(height: 32)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 84),
        child: Image.asset('assets/images/agenciala.png'));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  dynamic response;

  bool _isPasswordObscured = true;
  bool _showAuthError = false;

  Future login() async {
    String login = _login.text;
    String password = _password.text;

    setState(() {
      _showAuthError = false;
    });

    response =
        await Auth.signInUsingEmailPassword(email: login, password: password);

    if (response[0] == true) {
      print('User found! Proceed to sign in');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ClientMainScreen()),
      );
    } else {
      print("Error! ${response[1]}");
      setState(() {
        _showAuthError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira um e-mail';
                } else if (EmailValidator.validate(value)) {
                  return null;
                } else {
                  return 'Insira um e-mail válido';
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira uma senha';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Offstage(
              offstage: !_showAuthError,
              child: Column(
                children: [
                  Text(
                    response != null ? response[1] : '',
                    style: const TextStyle(color: AgenciaLaColors.negative),
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            ),
            LoginButton(
              login: login,
              formKey: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({required this.login, required this.formKey, super.key});

  final Function login;
  final GlobalKey<FormState> formKey;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isAuthenticating = false;

  void login() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
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
      onPressed: () {
        if (widget.formKey.currentState!.validate()) {
          if (isAuthenticating == false) {
            return login();
          }
          return;
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AgenciaLaColors.primary,
        foregroundColor: AgenciaLaColors.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: isAuthenticating
          ? const CircularProgressIndicator()
          : const Text(
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
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                ),
              },
              child: const Text(
                "Cadastre-se",
                style: TextStyle(
                  color: AgenciaLaColors.primary,
                  fontSize: 16,
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
