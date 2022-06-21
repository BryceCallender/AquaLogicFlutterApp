import 'dart:io';

import 'package:aqua_logic_controller/Models/aqualogic_provider.dart';
import 'package:aqua_logic_controller/UI/connect-page.dart';
import 'package:aqua_logic_controller/UI/pool-dashboard.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final Color dragoonBlue = Color(0xFF2845f9);

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayOpacity: 0.7,
        overlayWidget: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: dragoonBlue,
            size: 120,
          ),
        ),
        child: MaterialApp(
          title: "AquaLogic Controller",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
                .copyWith(primary: dragoonBlue, secondary: Colors.greenAccent),
            appBarTheme: AppBarTheme(
              backgroundColor: dragoonBlue,
            ),
            splashColor: dragoonBlue,
            snackBarTheme: SnackBarThemeData(
              backgroundColor: dragoonBlue,
              contentTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: MyHomePage(title: "AquaLogic Controller"),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool skipConnect = false;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var host = prefs.getString("host") ?? "";
    var port = prefs.getString("port") ?? "";

    print(host);
    print(port);

    setState(() {
      skipConnect = host.isNotEmpty && port.isNotEmpty;
      if (skipConnect) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PoolDashboard(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ConnectPage(),
    );
  }
}
