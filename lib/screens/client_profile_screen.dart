import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/colors.dart';
import 'package:agencia_la/network/database.dart';
import 'package:agencia_la/screens/client_edit_profile.dart';
import 'package:agencia_la/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  void logout(BuildContext context) {
    Auth.clearCurrentUser();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const LoginScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
      ProfileScaffold(
        size: size,
        topChildren: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => logout(context),
              icon: const Icon(Icons.logout, color: AgenciaLaColors.onPrimary,)
            ),
          ),
          const Text(
            'Perfil',
            style: TextStyle(fontSize: 34, color: AgenciaLaColors.onPrimary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 180,
              height: 180,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo_teal.png',
                      width: double.infinity,
                      height: 300, 
                      fit: BoxFit.cover                 
                    ),
                  ),
                ),
            ),
          )
        ],

        bottomChildren: [
          FutureBuilder(
            future: Database.getClientFullname(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                String name = snapshot.data as String;
                return Text(
                  name,
                  style: const TextStyle(color: AgenciaLaColors.onBackground, fontWeight: FontWeight.bold, fontSize: 26.0),
                );
              }
            }
          ),

          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.9,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textOption(
                      'Editar Perfil', 
                      (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ClientEditProfileScreen()
                          ),
                        );
                      }
                    ),
                    const Divider(thickness: 1.0),
                    _textOption(
                      'Fale Conosco',
                      () async {
                        var whatsapp ="+5592993557731";
                        String whatsappURlAndroid = "https://wa.me/$whatsapp";
                        Uri uri = Uri.parse(whatsappURlAndroid);
                        if( await canLaunchUrl(uri)){
                          await launch(whatsappURlAndroid);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Não foi possível direcionar ao Whatsapp")));
                        }
                      }
                    )
                    // _textOption('Carteira', (){Navigator.pop(context);}),
                    // const Divider(thickness: 1.0),
                    // _textOption('Crianças', (){Navigator.pop(context);}),
                    // const Divider(thickness: 1.0),
                    // _textOption('Endereços Perfil', (){Navigator.pop(context);}),
                    // const Divider(thickness: 1.0),

                  ],
                ),
              ),
            ),
          )
        ],


      );

  }

  _getName() async {
    final ref = FirebaseDatabase.instance.ref();
    dynamic userInfo; 
    userInfo = await ref.child('client/${Auth.getCurrentUser()!.uid}/info').get();
    if (userInfo.exists) {
      String name = userInfo.value['name'] + ' ' + userInfo.value['surname'];
      return name;
    } else {
      return '';
    }
  }

  _textOption(String text, Function onPressed){
    return TextButton(
      onPressed: () => onPressed(), 
      child: Text(text, style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 18),)
    );

  }
}


class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({
    Key? key,
    required Size size,
    List<Widget>? topChildren,
    List<Widget>? bottomChildren,

  })  : _size = size,
        _bottomChildren = bottomChildren,
        _topChildren = topChildren,
        super(key: key);

  final Size _size;
  final List<Widget>? _bottomChildren;
  final List<Widget>? _topChildren;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AgenciaLaColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: _size.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  bottom: -180,
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
      
                ),
      
                Positioned(
                  top: 30,
                  child: SizedBox(
                    width: _size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _topChildren ?? []
                      ),
                    ),
                  )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 220, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _bottomChildren ?? []
              ),
            )

      
          ],
        ),
      ),
    );
  }
}

