import 'package:fingerprint_auth_example/api/local_auth_api.dart';
import 'package:fingerprint_auth_example/main.dart';
import 'package:fingerprint_auth_example/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAvailability(context),
                SizedBox(height: 23),
                FingerprintPage()
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Ongoing',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();

          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check,
                    color: Color.fromARGB(255, 0, 107, 4), size: 24)
                : Icon(Icons.close, color: Colors.red, size: 25),
            const SizedBox(width: 13),
            Text(text, style: TextStyle(fontSize: 25)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context, Type fingerprintPage) =>
      buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      );

  Widget buildButton({
    @required String text,
    @required IconData icon,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
