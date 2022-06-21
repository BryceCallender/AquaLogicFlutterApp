class SaltLevel {
  DateTime eventTime;
  int ppm;

  SaltLevel(this.eventTime, this.ppm);

  factory SaltLevel.fromJson(Map<String, dynamic> json) {
    return SaltLevel(
        DateTime.parse(json["eventTime"]),
        json["salt"]
    );
  }
}