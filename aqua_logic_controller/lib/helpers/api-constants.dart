class ApiConstants {
  static String baseUrl = "https://localhost:5002";
  static String aquaHubUrl = "https://localhost:5001";

  //signalR + health check
  static String aqualogicHubEndpoint = "/aqualogichub";
  static String healthCheckEndpoint = "/health";

  //Aqualogic specific endpoints
  static String aquaLogicApiGroup = "/api/aqualogic";
  static String statesEndpoint = "$aquaLogicApiGroup/states";
  static String sendKeyEndpoint = "$aquaLogicApiGroup/key";
  static String setStateEndpoint = "$aquaLogicApiGroup/setstate";
}