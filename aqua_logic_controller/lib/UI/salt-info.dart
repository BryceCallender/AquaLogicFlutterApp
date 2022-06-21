import 'package:aqua_logic_controller/Models/dashboard-data.dart';
import 'package:aqua_logic_controller/UI/salt-graph.dart';
import 'package:aqua_logic_controller/helpers/ApiBaseHelper.dart';
import 'package:aqua_logic_controller/helpers/api-constants.dart';
import 'package:aqua_logic_controller/Models/salt-level.dart' as Dashboard;
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SaltInfo extends StatefulWidget {
  const SaltInfo({Key? key}) : super(key: key);

  @override
  State<SaltInfo> createState() => _SaltInfoState();
}

class _SaltInfoState extends State<SaltInfo> {
  late List<SaltLevel> saltData = [];

  @override
  void initState() {
    super.initState();
    ApiBaseHelper.get(ApiConstants.saltLevelEndpoint).then((resp) {
      var dashboardData = DashboardData.fromJson(resp);
      groupDateTimes(dashboardData.saltLevels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: IconButton(
              icon: Icon(Icons.calendar_month_rounded),
              onPressed: launchDatePicker),
          trailing: Icon(Icons.rotate_left),
        ),
        SizedBox(
          height: 200.0,
          child: SaltGraph(
            saltData,
            animate: true,
          ),
        ),
      ],
    );
  }

  void launchDatePicker() async {
    DateTime today = DateTime.now();
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1), // the earliest allowable
      lastDate: DateTime(today.year, 12, 31), // the latest allowable
      saveText: 'Done',
    );

    if (result != null) {
      ApiBaseHelper.get(ApiConstants.saltLevelEndpoint, {
        "begin": result.start.toIso8601String(),
        "end": result.end.toIso8601String()
      }).then((resp) {
        var dashboardData = DashboardData.fromJson(resp);
        groupDateTimes(dashboardData.saltLevels);
      });
    }
  }

  void groupDateTimes(List<Dashboard.SaltLevel>? saltLevels) {
    if (saltLevels == null) {
      return;
    }

    saltData = [];
    var years =
        groupBy(saltLevels, (Dashboard.SaltLevel sl) => sl.eventTime.year);

    DateTime today = DateTime.now();
    years.forEach((key, value) {
      var months =
          groupBy(value, (Dashboard.SaltLevel sl) => sl.eventTime.month);

      months.forEach((key, value) {
        double averagePPM = 0;

        DateTime eventData = today;

        value.forEach((element) {
          eventData = element.eventTime;
          averagePPM += element.ppm;
        });

        averagePPM /= value.length;

        DateTime event = DateTime(eventData.year, eventData.month);
        setState(() {
          saltData.add(SaltLevel(event, averagePPM.toInt()));
        });
      });
    });
  }
}
