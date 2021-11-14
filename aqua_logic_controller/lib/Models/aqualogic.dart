class AquaLogic {
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
      {this.poolStates,
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
      poolStates : json['PoolStates'],
      flashingStates : json['FlashingStates'],
      isMetric : json['IsMetric'],
      airTemp : json['AirTemp'],
      spaTemp : json['SpaTemp'],
      poolTemp : json['PoolTemp'],
      poolChlorinatorPercent : json['PoolChlorinatorPercent'],
      spaChlorinatorPercent : json['SpaChlorinatorPercent'],
      saltLevel : json['SaltLevel'],
      status : json['Status'],
      isHeaterEnabled : json['IsHeaterEnabled'],
      isSuperChlorinate : json['IsSuperChlorinate'],
      waterfall : json['Waterfall'],
      pumpSpeed : json['PumpSpeed'],
      pumpPower : json['PumpPower'],
      multiSpeedPump : json['MultiSpeedPump'],
      heaterAutoMode : json['HeaterAutoMode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['PoolStates'] = this.poolStates;
    data['FlashingStates'] = this.flashingStates;
    data['IsMetric'] = this.isMetric;
    data['AirTemp'] = this.airTemp;
    data['SpaTemp'] = this.spaTemp;
    data['PoolTemp'] = this.poolTemp;
    data['PoolChlorinatorPercent'] = this.poolChlorinatorPercent;
    data['SpaChlorinatorPercent'] = this.spaChlorinatorPercent;
    data['SaltLevel'] = this.saltLevel;
    data['Status'] = this.status;
    data['IsHeaterEnabled'] = this.isHeaterEnabled;
    data['IsSuperChlorinate'] = this.isSuperChlorinate;
    data['Waterfall'] = this.waterfall;
    data['PumpSpeed'] = this.pumpSpeed;
    data['PumpPower'] = this.pumpPower;
    data['MultiSpeedPump'] = this.multiSpeedPump;
    data['HeaterAutoMode'] = this.heaterAutoMode;
    return data;
  }
}
