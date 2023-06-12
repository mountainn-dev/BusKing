import 'package:busking/Repository/RemoteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Station.dart';

class StationViewModel with ChangeNotifier {
  // Station 뷰 모델은 station 을 선택하는 페이지를 구성하기 위한 뷰 모델이다.
  // 입력받은 routeId 를 통해 레포지토리에서 정류장 목록을 가져온다.
  late final RemoteRepository _remoteRepository;
  late final String _routeId;
  late List<Station> _station = [];
  late Station _start;
  late Station _end;
  var _isStartSelected = false;
  var _isEndSelected = false;
  var _cardColor = Colors.white;
  List<Station> get station => _station;
  Station get start => _start;
  Station get end => _end;
  bool get isStartSelected => _isStartSelected;
  bool get isEndSelected => _isEndSelected;
  Color get cardColor => _cardColor;

  StationViewModel(String routeId) {
    // station view 의 경우 이전 단계에서 선택된 버스를 기반으로 구성되므로, 객체가 생성되는 동시에
    // station 목록을 같이 load 한다.
    _routeId = routeId;
    _remoteRepository = RemoteRepository();
    _loadStation();
  }

  Future<void> _loadStation() async {
    _station = await _remoteRepository.getStation(_routeId);
    notifyListeners();
  }

  void test() {
    _cardColor = Colors.orange;
    notifyListeners();
  }
}