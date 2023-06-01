import 'package:busking/DataSource/RemoteDataSource.dart';
import 'package:busking/model/BusRoute.dart';

class BusRouteRepository {
  final RemoteDataSource dataSource = RemoteDataSource();

  Future<List<BusRoute>> getBus(String keyword) => dataSource.getBus(keyword);
}