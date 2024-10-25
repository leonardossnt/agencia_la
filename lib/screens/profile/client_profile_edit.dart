import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/client.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/network/database.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:agencia_la/screens/components/navigate_back.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:agencia_la/screens/profile/client_profile_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientProfileEditScreen extends StatefulWidget {
  const ClientProfileEditScreen({super.key});

  @override
  State<ClientProfileEditScreen> createState() =>
      _ClientProfileEditScreenState();
}

class _ClientProfileEditScreenState extends State<ClientProfileEditScreen> {
  final ref = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  dynamic response;
  bool _isPasswordObscured = true;

  bool isLoading = true;
  dynamic userInfo;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    final ref = FirebaseDatabase.instance.ref();
    userInfo =
        await ref.child('client/${Auth.getCurrentUser()!.uid}/info').get();
    if (userInfo.exists) {
      _name.text = userInfo.value['name'];
      _surname.text = userInfo.value['surname'];
      _phone.text = userInfo.value['phone'];
      _email.text = userInfo.value['email'];
    } else {
      print('No data available.');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
    return Scaffold(
        backgroundColor: AgenciaLaColors.background,
        body: ProfileScaffold(
          size: size,
          topChildren: [
            const SizedBox(height: 60),
            const NavigateBack(
              title: 'Perfil',
              color: AgenciaLaColors.onPrimary,
            ),
            const SizedBox(height: 12),
            const ScreenTitle(
              'Editar perfil',
              color: AgenciaLaColors.onPrimary,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: Database.getClientPicture(),
                builder: (context, snapshot) {
                  String pictureUrl =
                      snapshot.hasData ? snapshot.data as String : '';

                  return CircleAvatar(
                    backgroundColor: AgenciaLaColors.inputBackground,
                    backgroundImage: AssetImage('assets/images/logo_teal.png'),
                    foregroundImage:
                        snapshot.hasData ? NetworkImage(pictureUrl) : null,
                    radius: 68,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Função não implementada")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AgenciaLaColors.primary,
                    foregroundColor: AgenciaLaColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 4),
                      Text('Alterar imagem'),
                    ],
                  ),
                ),
              ),
            )
          ],
          bottomChildren: [
            const SizedBox(height: 8),
            isLoading
                ? const CircularProgressIndicator()
                : Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                prefixIconColor: AgenciaLaColors.secondary,
                                border: InputBorder.none,
                                hintText: 'Nome',
                                contentPadding:
                                    EdgeInsets.only(left: 30, top: 15)),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu nome';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _surname,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                prefixIconColor: AgenciaLaColors.secondary,
                                border: InputBorder.none,
                                hintText: 'Sobrenome',
                                contentPadding:
                                    EdgeInsets.only(left: 30, top: 15)),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu sobrenome';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _phone,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                prefixIconColor: AgenciaLaColors.secondary,
                                border: InputBorder.none,
                                hintText: 'Telefone',
                                contentPadding:
                                    EdgeInsets.only(left: 30, top: 15)),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [maskFormatterPhone],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu telefone';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                prefixIconColor: AgenciaLaColors.secondary,
                                border: InputBorder.none,
                                hintText: 'Email',
                                contentPadding:
                                    EdgeInsets.only(left: 30, top: 15)),
                            keyboardType: TextInputType.emailAddress,
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
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _password,
                            obscureText: _isPasswordObscured,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: AgenciaLaColors.secondary,
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured =
                                          !_isPasswordObscured;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: 'Senha',
                                contentPadding:
                                    const EdgeInsets.only(left: 30, top: 15)),
                            validator: (value) {
                              if ((value?.length ?? 0) < 8 &&
                                  (value?.length ?? 0) > 0) {
                                return 'Sua senha deve conter no mínimo 8 caracteres';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 20),
            _saveChangesButton(_formKey),
            const SizedBox(height: 15),
          ],
        ));
  }

  _saveChangesButton(GlobalKey<FormState> formKey) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            updateUserInfo();
            return;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AgenciaLaColors.primary,
          foregroundColor: AgenciaLaColors.onPrimary,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: const Text(
          "Salvar alterações",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  Future updateUserInfo() async {
    String name = _name.text;
    String surname = _surname.text;
    String phone = _phone.text;
    String email = _email.text;
    String password = _password.text;

    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();

    var client =
        Client(name: name, surname: surname, phone: phone, email: email);

    await Database.updateClientInfo(client, password)
        .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ClientMainScreen()),
            ));
  }
}
