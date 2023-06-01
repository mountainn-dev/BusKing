import 'dart:convert';
import 'package:busking/DataSource/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/DataSource/JsonDecode.dart';
import 'package:busking/model/Bus.dart';
import 'package:busking/model/Station.dart';

class RemoteDataSource {
  // BusRoute 모델 리스트를 가진 busList 반환
  Future<List<Bus>> getBus(String keyword) async {
    List<dynamic> busData = await _callBusData(keyword);
    List<Bus> busList = [];
    for (int i = 0; i < busData.length; i++) {
      busList.add(Bus.fromJson(busData[i]));
    }

    return busList;
  }

  Future<List<Station>> getStation(String routeId) async {
    List<dynamic> stationData = await _callStationList(routeId);
    List<Station> stationList = [];
    for (int i = 0; i < stationData.length; i++) {
      stationList.add(Station.fromJson(stationData[i]));
    }

    return stationList;
  }

  Future<List<dynamic>> _callBusData(String keyword) async {
    // keyword 를 이용하여 버스 번호(routeName)와 노선 id(routeId) 목록을 가진 busData 반환
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;

    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    switch (JsonDecode.findStringByKey("resultCode", jsonBusData)) {
    // resultCode 0 - 데이터 호출 정상
    // 그 외 - 호출 실패
      case "0": {
        // 키워드 검색으로 반환된 버스가 하나만 존재할 경우 Json value 가 List 타입이 아닌
        // Map 타입으로 반환되기 때문에, 아래와 같이 분기문을 진행한다.
        busData = JsonDecode.findListByKey("busRouteList", jsonBusData);
        if (busData.length == 0)
          busData = [JsonDecode.findMapByKey("busRouteList", jsonBusData)];
        break;
      }
      default: {
        busData = [{"routeName" : "버스 정보가 존재하지 않습니다.", "routeId" : "-"}];
      }
    }

    return busData;
  }

  Future<List<dynamic>> _callStationList(String routeId) async {
    // 노선 id를 이용하여 해당 버스의 노선 목록 호출
    Uri url;
    Map<String, dynamic> jsonRouteData;
    List<dynamic> stationData;
    url = Uri.parse(APIUrl.getStationListUrl(routeId));
    var response = await http.get(url);
    jsonRouteData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    switch(JsonDecode.findStringByKey("resultCode", jsonRouteData)) {
      case "0": {
        // 정류장은 항상 목록으로 호출되기 때문에 버스 data 와 다르게 별도 분기코드를 진행하지 않는다.
        stationData = JsonDecode.findListByKey("busRouteStationList", jsonRouteData);
        break;
      }
      default: {
        stationData = [{"stationName" : "정류장 정보가 존재하지 않습니다.", "routeId" : "-"}];
      }
    }

    return stationData;
  }
}
