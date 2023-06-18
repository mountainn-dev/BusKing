import 'package:busking/Repository/RemoteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Station.dart';

class StationViewModel with ChangeNotifier {
  // Station 뷰 모델은 station 을 선택하는 페이지를 구성하기 위한 뷰 모델이다.
  // 입력받은 routeId 를 통해 레포지토리에서 정류장 목록을 가져온다.
  late final RemoteRepository _remoteRepository;
  late final String _routeId;
  late List<Station> _station = [];
  late Station? _start;   // UserStation 위젯에서 사용되기 위해 nullable 설정
  late Station? _end;
  bool _disposed = false;
  bool _isStartSelected = false;
  bool _isEndSelected = false;
  List<Station> get station => _station;
  Station? get start => _start;
  Station? get end => _end;
  bool get isStartSelected => _isStartSelected;
  bool get isEndSelected => _isEndSelected;

  StationViewModel(String routeId) {
    // station view 의 경우 이전 단계에서 선택된 버스를 기반으로 구성되므로, 객체가 생성되는 동시에
    // station 목록을 같이 load 한다.
    _routeId = routeId;
    _remoteRepository = RemoteRepository();
    _loadStation();
  }

  Future<void> _loadStation() async {
    _station = await _remoteRepository.getStation(_routeId);
    _notifyListeners();
  }

  void setStartToEnd(Station station) {
    if (_isStartSelected
        && start!.stationName.compareTo(station.stationName) == 0
    ) {
      _unsetStart();
    } else if (_isEndSelected
        && end!.stationName.compareTo(station.stationName) == 0
    ) {
      _unsetEnd();
    } else if (!_isStartSelected) {
      _setStart(station);
    } else if (!_isEndSelected) {
      _setEnd(station);
    }
    _notifyListeners();
  }

  void _setStart(Station station) {
    _start = station;
    _isStartSelected = true;
  }

  void _setEnd(Station station) {
    _end = station;
    _isEndSelected = true;
  }

  void _unsetStart() {
    _start = null;
    _isStartSelected = false;
  }

  void _unsetEnd() {
    _end = null;
    _isEndSelected = false;
  }

  void _notifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override void dispose() {
    _disposed = true;
    super.dispose();
  }

}