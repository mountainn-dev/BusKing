import 'package:busking/DataSource/RemoteDataSource.dart';
import 'package:busking/model/Bus.dart';

class BusRouteRepository {
  final RemoteDataSource dataSource = RemoteDataSource();

  Future<List<Bus>> getBus(String keyword) => dataSource.getBus(keyword);
}