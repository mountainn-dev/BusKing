import 'dart:convert';

class JsonDecode{
  static final _mapType = (jsonDecode('{"A" : "B"}')).runtimeType;   // _Map<String, dynamic>

  // key 값을 인자로 하여 value 를 탐색한다. 이 때, 순환함수를 사용하기 때문에 리턴 시 null check를
  // 하지 않고, 외부에서 체크하도록 nullable 값을 그대로 넘긴다.
  static String? findStringByKeyInMap(String k, Map<String, dynamic> m) {
    String? result;

    for (var key in m.keys) {
      if (m[key].runtimeType == _mapType) result = findStringByKeyInMap(k, m[key]);   // Map 형태의 value 일 경우 순환함수
      else if (m[key].runtimeType == String && key == k) result = m[key];   // String value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }

  static List<dynamic>? findListByKeyInMap(String k, Map<String, dynamic> m) {
    List<dynamic>? result;

    for (var key in m.keys) {
      if (m[key].runtimeType == _mapType) result = findListByKeyInMap(k, m[key]);
      else if (m[key].runtimeType == List && key == k) result = m[key];   // Map 형태의 value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }
}