import 'dart:convert';
import 'package:busking/DataSource/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/DataSource/JsonDecode.dart';
import 'package:busking/model/Bus.dart';
import 'package:busking/model/Station.dart';

class RemoteDataSource {
  // Bus 목록 반환
  // 버스의 기-종점은 routeId 를 기반으로 데이터 호출이 가능하다. 키워드와 정확히 일치하는 버스만을
  // 추려낸 뒤, 해당 버스들의 기-종점을 호출하여 최종 Bus 모델 목록을 반환한다.
  // 버스를 추리지 않고 진행할 경우, 기-종점 정보를 호출하는 작업이 상당히 많이 발생하기 때문에 해당
  // 과정을 추가했다.
  Future<List<Bus>> getBus(String keyword) async {
    List<dynamic> busData = await _callBusData(keyword);
    List<String> routeIdList = _getRouteIdFromBusData(busData);
    List<Bus> busList = [];

    for (int i = 0; i < busData.length; i++) {
      Map<String, dynamic> busDetailData = await _callBusDetailData(routeIdList[i]);
      busList.add(Bus.fromJson(busData[i], busDetailData));
    }
    return busList;
  }

  // 정류장 목록 반환
  Future<List<Station>> getStation(String routeId) async {
    List<dynamic> stationData = await _callStationData(routeId);
    List<Station> stationList = [];
    for (int i = 0; i < stationData.length; i++) {
      stationList.add(Station.fromJson(stationData[i]));
    }
    return stationList;
  }

  Future<List<dynamic>> _callBusData(String keyword) async {
    // keyword 를 이용하여 버스 번호(routeName)와 노선 id(routeId) 목록을 가진 busData 반환
    // 버스 목록을 반환하기 전에 removeBusNotExactlySameWithKeyword 메서드를 사용하여
    // 사용자 키워드와 정확히 일치하는 데이터만을 추려내어 버스 목록을 구성한다.
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData = [];

    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    // resultCode 0 - 데이터 정상 호출
    // 키워드 검색으로 반환된 버스가 하나만 존재할 경우 Json value 가 List 타입이 아닌
    // Map 타입으로 반환되기 때문에, 아래와 같이 JsonDecode 를 추가 진행해준다.
    String resultcode = JsonDecode.findStringByKey("resultCode", jsonBusData);
    if (resultcode == "0") {
      busData = JsonDecode.findListByKey("busRouteList", jsonBusData);
      if (busData.length == 0)
        busData = [JsonDecode.findMapByKey("busRouteList", jsonBusData)];
    }

    // keyword 와 정확히 일치하지 않는 데이터 삭제
    _removeBusNotExactlySameWithKeyword(keyword, busData);

    return busData;
  }

  Future<Map<String, dynamic>> _callBusDetailData(String routeId) async {
    // 노선 id를 이용하여 해당 버스의 상세 정보를 담은 busDetailData 반환
    Uri url;
    Map<String, dynamic> jsonBusDetailData;
    Map<String, dynamic> busDetailData = {};
    url = Uri.parse(APIUrl.getBusDetailUrl(routeId));
    var response = await http.get(url);
    jsonBusDetailData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    String resultCode = JsonDecode.findStringByKey("resultCode", jsonBusDetailData);
    if (resultCode == "0")
      busDetailData = JsonDecode.findMapByKey("busRouteInfoItem", jsonBusDetailData);

    return busDetailData;
  }

  Future<List<dynamic>> _callStationData(String routeId) async {
    // 노선 id를 이용하여 해당 버스의 정류장 목록을 가진 stationData 반환
    Uri url;
    Map<String, dynamic> jsonStationData;
    List<dynamic> stationData = [];
    url = Uri.parse(APIUrl.getStationListUrl(routeId));
    var response = await http.get(url);
    jsonStationData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    String resultCode = JsonDecode.findStringByKey("resultCode", jsonStationData);
    if (resultCode == "0")
      stationData = JsonDecode.findListByKey("busRouteStationList", jsonStationData);

    return stationData;
  }

  void _removeBusNotExactlySameWithKeyword(String keyword, List<dynamic> data) {
    data.removeWhere(
            (bus) => keyword.compareTo(
                JsonDecode.findStringByKey("routeName", bus as Map<String, dynamic>)
            ) != 0
    );
  }

  List<String> _getRouteIdFromBusData(List<dynamic> data) {
    List<String> routeIdList = [];

    for (int i = 0; i < data.length; i++) {
      routeIdList.add(JsonDecode.findStringByKey("routeId", data[i]));
    }

    return routeIdList;
  }
}
