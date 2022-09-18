import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_example/page/home_page.dart';

import 'my_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Speech to Text';

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Manage()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: ThemeData(primarySwatch: Colors.purple),
            home: HomePage(),
          ));
}
