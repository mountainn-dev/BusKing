import 'package:busking/Repository/RemoteRepository.dart';
import 'package:flutter/material.dart';
import 'package:busking/model/Bus.dart';

class BusViewModel with ChangeNotifier {
  // Bus 뷰 모델은 bus 를 선택하는 페이지를 구성하기 위한 뷰 모델이다.
  // 입력받은 keyword 를 통해 레포지토리에서 버스 목록과 노선 id 목록을 가져온다.
  late final RemoteRepository _remoteRepository;
  late List<Bus> _bus = [];
  List<Bus> get bus => _bus;
  var _keyword = "";

  BusViewModel() {
    _remoteRepository = RemoteRepository();
  }

  void setKeyword(String k) {
    _keyword = k;
  }

  Future<void> loadBus() async {
    _bus = await _remoteRepository.getBus(_keyword);
    notifyListeners();
  }
}
