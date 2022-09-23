import 'package:agencia_la/colors.dart';
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
            ScreenTitle(),
            SizedBox(
              height: 48,
            ),
            Logo(),
            SizedBox(height: 48),
            LoginForm()
          ],
        ))));
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Bem vindo!",
        style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AgenciaLaColors.darkPrimary));
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/agenciala.png');
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
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
          const LoginButton(),
          const SizedBox(height: 32),
          const SignUpText(),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AgenciaLaColors.primary,
        foregroundColor: AgenciaLaColors.onPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: const Text(
        "Entrar",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
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
                        onTap: () => {},
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(
                            color: AgenciaLaColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
