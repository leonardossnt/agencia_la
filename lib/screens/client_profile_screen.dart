import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/title.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/network/database.dart';
import 'package:agencia_la/screens/client_edit_profile.dart';
import 'package:agencia_la/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

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
    return ProfileScaffold(
      size: size,
      topChildren: [
        const SizedBox(height: 60),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: IconButton(
                onPressed: () => logout(context),
                icon: const Icon(
                  Icons.logout,
                  size: 32,
                  color: AgenciaLaColors.onPrimary,
                )),
          ),
        ),
        const SizedBox(height: 12),
        const ScreenTitle(
          'Perfil',
          color: AgenciaLaColors.onPrimary,
        ),
        const Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: AgenciaLaColors.inputBackground,
            backgroundImage: AssetImage('assets/images/logo_teal.png'),
            // foregroundImage: NetworkImage(<url here>),
            radius: 90,
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
                  style: const TextStyle(
                      color: AgenciaLaColors.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 32),
                );
              }
            }),
        const SizedBox(height: 24),
        SizedBox(
          // width: size.width * 0.9, // TODO: check if it is needed
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _profileOption('Editar Perfil', true, () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ClientEditProfileScreen()));
                  }),
                  _profileOption('Fale Conosco', false, _talkToUsWhatsapp(context)),
                  // _profileOption('Carteira', false, () { Navigator.pop(context); }),
                  // _profileOption('Crianças', false, () { Navigator.pop(context); }),
                  // _profileOption('Endereços', false, () { Navigator.pop(context); }),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _profileOption(String text, bool firstElement, Function onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        firstElement ? Container() : const Divider(thickness: 1.0),
        TextButton(
            onPressed: () => onPressed(),
            child: Text(
              text,
              style: const TextStyle(
                  color: AgenciaLaColors.foreground,
                  fontWeight: FontWeight.w500,
                  fontSize: 22),
            ))
      ],
    );
  }

  Function _talkToUsWhatsapp(BuildContext context) {
    return () async {
      var wppPhone = "+5592993557731";
      String wppUrlAndroid = "https://wa.me/$wppPhone";
      Uri uri = Uri.parse(wppUrlAndroid);
      if (await UrlLauncher.canLaunchUrl(uri)) {
        await UrlLauncher.launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Não foi possível direcionar ao Whatsapp"),
        ));
      }
    };
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
                  decoration: const BoxDecoration(
                    color: AgenciaLaColors.primary,
                  ),
                ),
                Positioned(
                  bottom: -180,
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: const BoxDecoration(
                      color: AgenciaLaColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: SizedBox(
                    width: _size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _topChildren ?? []
                    ),
                  )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 200, 24, 0),
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

