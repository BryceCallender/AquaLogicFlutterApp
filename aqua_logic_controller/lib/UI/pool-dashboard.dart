import 'package:aqua_logic_controller/UI/emulator.dart';
import 'package:aqua_logic_controller/UI/pool-controls.dart';
import 'package:aqua_logic_controller/UI/configuration-page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/aqualogic_provider.dart';

class PoolDashboard extends StatefulWidget {
  const PoolDashboard({Key? key}) : super(key: key);

  @override
  _PoolDashboardState createState() => _PoolDashboardState();
}

class _PoolDashboardState extends State<PoolDashboard> {
  int _selectedIndex = 0;
  late AquaLogicProvider aquaProvider;

  List<Widget> _widgets = <Widget>[
    PoolControls(),
    Emulator(),
    ConfigurationPage(),
  ];

  @override
  void initState() {
    super.initState();
    aquaProvider = Provider.of<AquaLogicProvider>(context, listen: false);
    aquaProvider.subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaLogic Dashboard'),
      ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_remote),
              label: 'Remote',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.keyboard),
              label: 'Emulator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuration',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
