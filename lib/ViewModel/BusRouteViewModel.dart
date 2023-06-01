import 'package:busking/Repository/BusRouteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';

class BusRouteViewModel with ChangeNotifier {
  // BusRoute 뷰 모델은 bus, station 을 선택하는 페이지를 구성하기 위한 뷰 모델이다.
  // 입력받은 keyword 를 통해 레포지토리에서 버스 목록과 노선 id 목록을 가져온다.
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
