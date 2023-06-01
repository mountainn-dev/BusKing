import 'dart:convert';

class JsonDecode{
  static final _mapType = (jsonDecode('{"A" : "B"}')).runtimeType;   // _Map<String, dynamic>
  // 중첩된 Json 데이터에서 원하는 Value 를 key 값으로 구하기 위해 작성한 클래스이다.
  // key 값을 인자로 하여 value 를 탐색한다. 이 때, 순환함수를 사용하기 때문에 메서드를 둘로 나눠
  // 각각 탐색과 null check 를 담당하도록 한다.
  static String findStringByKey(String k, Map<String, dynamic> m) {
    return _findStringByKeyInMap(k, m) ?? "";
  }

  static List<dynamic> findListByKey(String k, Map<String, dynamic> m) {
    return _findListByKeyInMap(k, m) ?? [];
  }

  static Map<String, dynamic> findMapByKey(String k, Map<String, dynamic> m) {
    return _findMapByKeyInMap(k, m) ?? {"" : ""};
  }

  static String? _findStringByKeyInMap(String k, Map<String, dynamic> m) {
    String? result;

    for (var key in m.keys) {
      if (m[key].runtimeType == _mapType) result = _findStringByKeyInMap(k, m[key]);   // Map 형태의 value 일 경우 순환함수
      else if (m[key].runtimeType == String && key == k) result = m[key];   // String value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }

  static List<dynamic>? _findListByKeyInMap(String k, Map<String, dynamic> m) {
    List<dynamic>? result;

    for (var key in m.keys) {
      if (m[key].runtimeType == _mapType) result = _findListByKeyInMap(k, m[key]);
      else if (m[key].runtimeType == List && key == k) result = m[key];   // Map 형태의 value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }

  static Map<String, dynamic>? _findMapByKeyInMap(String k, Map<String, dynamic> m) {
    Map<String, dynamic>? result;

    for (var key in m.keys) {
      if (m[key].runtimeType == _mapType && key != k) result = _findMapByKeyInMap(k, m[key]);
      else if (m[key].runtimeType == _mapType && key == k) result = m[key];   // Map 형태의 value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }
}