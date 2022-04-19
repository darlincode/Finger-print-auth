import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/fingerprint_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Local Auth';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: true,
        title: title,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: FingerprintPage(),
      );
}
