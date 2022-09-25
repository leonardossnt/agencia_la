import 'package:agencia_la/auth/auth.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agencia_la/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AgenciaLaColors.background,
        body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    SizedBox(height: 120),
                    ScreenTitle(),
                    SizedBox(height: 84),
                    SignUpForm(),
                    SizedBox(height: 60)
                  ],
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
            child: Text("Criar conta",
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  Future signUp() async {
    String login = _email.text;
    String password = _password.text;

    User? user = await Auth.registerUsingEmailPassword(
        email: login, password: password);

    if (user != null) {
      print('Created user! Proceed to sign in');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ClientMainScreen()
        ),
      );
    } else {
      // TODO: show error message
      print('User was not created!');
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
            controller: _name,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Nome',
              prefixIcon: const Icon(Icons.person),
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
            controller: _surname,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Sobrenome',
              prefixIcon: const Icon(Icons.person),
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
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Telefone',
              prefixIcon: const Icon(Icons.phone),
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
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
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
              labelText: 'Senha',
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
          TextField(
            controller: _confirmPassword,
            keyboardType: TextInputType.text,
            obscureText: _isConfirmPasswordObscured,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Confirmar senha',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_isConfirmPasswordObscured
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
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
          const DisclaimerCheckbox(),
          const SizedBox(height: 32),
          SignUpButton(signUp: signUp),
        ],
      ),
    );
  }
}

class DisclaimerCheckbox extends StatefulWidget {
  const DisclaimerCheckbox({Key? key}) : super(key: key);

  @override
  State<DisclaimerCheckbox> createState() => _DisclaimerCheckboxState();
}

class _DisclaimerCheckboxState extends State<DisclaimerCheckbox> {
  bool _isDisclaimerChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: _isDisclaimerChecked,
        contentPadding: EdgeInsets.zero,
        title: const DisclaimerText(),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool? value) => {
          setState(() {
            _isDisclaimerChecked = !_isDisclaimerChecked;
          })
        },
    );
  }
}

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(
            color: AgenciaLaColors.onBackground,
            fontSize: 14,
          ),
          children: <InlineSpan>[
            const TextSpan(text: 'Li e concordo com os ',),
            WidgetSpan(
              child: InkWell(
                onTap: () => {
                  // TODO: Termos de uso
                },
                child: const Text(
                  "Termos de Uso",
                  style: TextStyle(
                    color: AgenciaLaColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const TextSpan(text: ' e ',),
            WidgetSpan(
              child: InkWell(
                onTap: () => {
                  // TODO: Política de privacidade
                },
                child: const Text(
                  "Política de Privacidade",
                  style: TextStyle(
                    color: AgenciaLaColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const TextSpan(text: ' desse serviço',),
          ],
        ),
      );
  }
}


class SignUpButton extends StatefulWidget {
  const SignUpButton({required this.signUp, super.key});
  final Function signUp;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool isAuthenticating = false;

  void login() async {
    setState(() {
      isAuthenticating = true;
    });
    await widget.signUp();
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
        "Concluir cadastro",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}