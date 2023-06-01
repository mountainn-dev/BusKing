import 'package:busking/Repository/BusRouteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Bus.dart';

class StationViewModel with ChangeNotifier {
  // Station 뷰 모델은 station 을 선택하는 페이지를 구성하기 위한 뷰 모델이다.
  // 입력받은 routeId 를 통해 레포지토리에서 정류소 목록을 가져온다.
  late final BusRouteRepository _busRouteRepository;
  late List<Bus> _busRoute = [];
  List<Bus> get bus => _busRoute;
  var _keyword = "";

  StationViewModel() {
    _busRouteRepository = BusRouteRepository();
  }

  void setKeyword(String k) {
    _keyword = k;
  }

  Future<void> loadBus() async {
    _busRoute = await _busRouteRepository.getBus(_keyword);
    notifyListeners();
  }
}