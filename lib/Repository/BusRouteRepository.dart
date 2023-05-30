import 'package:busking/DataSource/RemoteDataSource.dart';
import 'package:busking/model/BusRoute.dart';

class BusRouteRepository {
  final RemoteDataSource dataSource = RemoteDataSource();

  Future<BusRoute> getBusData(String keyword) => dataSource.getBusData(keyword);
}