import 'package:busking/DataSource/JsonDecode.dart';

class BusRoute{
  // BusRoute 모델은 버스 번호와 노선 id 로 구성
  final String routeName;
  final String routeId;

  BusRoute({
    required this.routeName,
    required this.routeId
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
        routeName: JsonDecode.findStringByKey("routeName", json),
        routeId: JsonDecode.findStringByKey("routeId", json)
    );
  }
}