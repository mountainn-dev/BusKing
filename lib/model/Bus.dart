import 'package:busking/DataSource/JsonDecode.dart';

class Bus{
  // Bus 모델은 버스 번호와 노선 id 로 구성
  final String routeName;
  final String routeId;
  final String startStationName;
  final String endStationName;

  Bus({
    required this.routeName,
    required this.routeId,
    required this.startStationName,
    required this.endStationName
  });

  factory Bus.fromJson(
      Map<String, dynamic> busJson,
      Map<String, dynamic> busDetailJson
      ) {
    return Bus(
        routeName: JsonDecode.findStringByKey("routeName", busJson),
        routeId: JsonDecode.findStringByKey("routeId", busJson),
        startStationName: JsonDecode.findStringByKey("startStationName", busDetailJson),
        endStationName: JsonDecode.findStringByKey("endStationName", busDetailJson)
    );
  }
}