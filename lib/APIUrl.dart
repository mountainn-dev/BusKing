import 'package:busking/APIKey.dart';

class APIUrl {
  static String getBusListUrl(String keyWord) {
    return "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteList?"
        "serviceKey=${APIKey.getRouteKey()}&keyword=$keyWord";
  }
  static String getRouteListUrl(String routeId) {
    return "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteStationList?"
        "serviceKey=${APIKey.getRouteKey()}&routeId=$routeId";
  }
  static String getArrivalListUrl(String stationId) {
    //
    return "";
  }
}