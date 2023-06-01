import 'package:busking/DataSource/JsonDecode.dart';

class Station{
  // Station 모델은 정류장 이름과 정류장 id 로 구성
  final String stationName;
  final String stationId;

  Station({
    required this.stationName,
    required this.stationId
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
        stationName: JsonDecode.findStringByKey("stationName", json),
        stationId: JsonDecode.findStringByKey("stationId", json)
    );
  }
}