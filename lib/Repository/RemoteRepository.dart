import 'package:busking/DataSource/RemoteDataSource.dart';
import 'package:busking/model/Bus.dart';
import 'package:busking/model/Station.dart';

class RemoteRepository {
  // 외부 API 데이터 레포지토리는 하나로 통합하였다.
  final RemoteDataSource dataSource = RemoteDataSource();

  Future<List<Bus>> getBus(String keyword) => dataSource.getBus(keyword);
  Future<List<Station>> getStation(String routeId) => dataSource.getStation(routeId);
}