import 'package:busking/Repository/BusRouteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';

class BusRouteViewModel with ChangeNotifier {
  late final BusRouteRepository _busRouteRepository;
  late  List<String> _busList;
  late  List<String> _routeIdList;
  var _keyword = "";
  List<String> get busList => _busList;
  List<String> get routeIdList => _routeIdList;

  BusRouteViewModel() {
    _busRouteRepository = BusRouteRepository();
  }

  void setKeyword(String k) {
    _keyword = k;
  }

  Future<void> getBusData() async {
    BusRoute busRoute = await _busRouteRepository.getBusData(_keyword);
    _busList = busRoute.busList;
    _routeIdList = busRoute.routeIdList;
    notifyListeners();
  }
}
