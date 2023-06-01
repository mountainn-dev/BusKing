import 'package:busking/DataSource/JsonDecode.dart';

class Bus{
  // Bus 모델은 버스 번호와 노선 id 로 구성
  final String routeName;
  final String routeId;

  Bus({
    required this.routeName,
    required this.routeId
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
        routeName: JsonDecode.findStringByKey("routeName", json),
        routeId: JsonDecode.findStringByKey("routeId", json)
    );
  }
}