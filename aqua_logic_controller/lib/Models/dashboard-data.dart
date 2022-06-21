import 'package:aqua_logic_controller/Models/salt-level.dart';

class DashboardData {
  List<SaltLevel>? saltLevels;

  DashboardData({this.saltLevels});

  factory DashboardData.fromJson(List<dynamic> json) {
    var saltLevels = <SaltLevel>[];
    json.forEach((v) {
      saltLevels.add(SaltLevel.fromJson(v));
    });

    return DashboardData(
      saltLevels: saltLevels
    );
  }
}