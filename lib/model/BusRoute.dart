import 'package:busking/DataSource/JsonDecode.dart';

class BusRoute{
  // XML 타입의 API 데이터를 JSON 으로 변환 후 리스트로 매핑하는 과정이 복잡하여,
  // remoteDataSource 에서 매핑이 완성된 데이터를 BusRoute 모델에 전달하게끔 코드를 구성했다.
  final List<String> busList;
  final List<String> routeIdList;

  BusRoute({
    required this.busList,
    required this.routeIdList
});
}