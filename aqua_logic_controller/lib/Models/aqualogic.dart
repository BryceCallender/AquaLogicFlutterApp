import 'display.dart';

class AquaLogic {
  Display? display;
  int? poolStates;
  int? flashingStates;
  bool? isMetric;
  int? airTemp;
  int? spaTemp;
  int? poolTemp;
  int? poolChlorinatorPercent;
  int? spaChlorinatorPercent;
  int? saltLevel;
  String? status;
  bool? isHeaterEnabled;
  bool? isSuperChlorinate;
  bool? waterfall;
  int? pumpSpeed;
  int? pumpPower;
  bool? multiSpeedPump;
  bool? heaterAutoMode;

  AquaLogic(
      {this.display,
      this.poolStates,
      this.flashingStates,
      this.isMetric,
      this.airTemp,
      this.spaTemp,
      this.poolTemp,
      this.poolChlorinatorPercent,
      this.spaChlorinatorPercent,
      this.saltLevel,
      this.status,
      this.isHeaterEnabled,
      this.isSuperChlorinate,
      this.waterfall,
      this.pumpSpeed,
      this.pumpPower,
      this.multiSpeedPump,
      this.heaterAutoMode});

  factory AquaLogic.fromJson(Map<String, dynamic> json) {
    return AquaLogic(
      display: Display.fromJson(json['display']),
      poolStates : json['poolStates'],
      flashingStates : json['flashingStates'],
      isMetric : json['isMetric'],
      airTemp : json['airTemp'],
      spaTemp : json['spaTemp'],
      poolTemp : json['poolTemp'],
      poolChlorinatorPercent : json['poolChlorinatorPercent'],
      spaChlorinatorPercent : json['spaChlorinatorPercent'],
      saltLevel : json['saltLevel'],
      status : json['status'],
      isHeaterEnabled : json['isHeaterEnabled'],
      isSuperChlorinate : json['isSuperChlorinate'],
      waterfall : json['waterfall'],
      pumpSpeed : json['pumpSpeed'],
      pumpPower : json['pumpPower'],
      multiSpeedPump : json['multiSpeedPump'],
      heaterAutoMode : json['heaterAutoMode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['display'] = this.display;
    data['poolStates'] = this.poolStates;
    data['flashingStates'] = this.flashingStates;
    data['isMetric'] = this.isMetric;
    data['airTemp'] = this.airTemp;
    data['spaTemp'] = this.spaTemp;
    data['poolTemp'] = this.poolTemp;
    data['poolChlorinatorPercent'] = this.poolChlorinatorPercent;
    data['spaChlorinatorPercent'] = this.spaChlorinatorPercent;
    data['saltLevel'] = this.saltLevel;
    data['status'] = this.status;
    data['isHeaterEnabled'] = this.isHeaterEnabled;
    data['isSuperChlorinate'] = this.isSuperChlorinate;
    data['waterfall'] = this.waterfall;
    data['pumpSpeed'] = this.pumpSpeed;
    data['pumpPower'] = this.pumpPower;
    data['multiSpeedPump'] = this.multiSpeedPump;
    data['heaterAutoMode'] = this.heaterAutoMode;

    return data;
  }
}
