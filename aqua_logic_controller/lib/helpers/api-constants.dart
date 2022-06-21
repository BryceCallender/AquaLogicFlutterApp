class ApiConstants {
  static String baseUrl = "https://localhost:5001";

  // signalr + health check
  static String aqualogicHubEndpoint = "/aqualogichub";
  static String healthCheckEndpoint = "/health";

  // dashboard information
  static String dashboardEndpoint = "/api/dashboard";
  static String saltLevelEndpoint = "$dashboardEndpoint/salt-levels";

  // aqualogic specific endpoints
  static String aquaLogicApiGroup = "/api/aqualogic";
  static String statesEndpoint = "$aquaLogicApiGroup/states";
  static String sendKeyEndpoint = "$aquaLogicApiGroup/key";
  static String setStateEndpoint = "$aquaLogicApiGroup/setstate";
}