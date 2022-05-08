import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/connect-page.dart';
import 'package:aqua_logic_controller/UI/pool-controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AquaLogicProvider>(
        create: (_) => AquaLogicProvider()),
  ];

  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaLogic Controller',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue, brightness: Brightness.dark)
              .copyWith(secondary: Colors.greenAccent),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
          splashColor: Colors.blue),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'AquaLogic Controller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ConnectPage());
  }
}
