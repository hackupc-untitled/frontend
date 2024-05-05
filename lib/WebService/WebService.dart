import 'dart:convert';

import 'package:http/http.dart' as http;

import 'RequestMaker.dart';

class WebService {
  static final HOST = "http://185.185.83.212:5000/save";
  static final TEST = "";
  static final GETLOCATIONS = "http://185.185.83.212:5000/getLocations";
  static final GETLGALILEOS = "http://185.185.83.212:5000/getGalileos";
  static final GETSATINFO = "http://185.185.83.212:5000/getSatInfo";

  static final GETUSERPOS = "http://185.185.83.212:5000/getUserPos";
  static final GETUGRAFIC = "http://185.185.83.212:5000/getGraphic";

  static Future<String> send(String measurement, Map<String, dynamic> tags,
      Map<String, dynamic> fields, int user_id) async {
    fields["user_id"] = user_id.toString();
    String url = HOST + TEST;
    Map<String, dynamic> body = {
      "measurement": measurement,
      "tags": tags,
      "fields": fields,
    };
    print("url Create User " + url);
    print("body Create User: " + body.toString());
    RequestMaker().post(url, body, false);
    return "a";
  }

  static Future<Map<String, dynamic>> getLocations(int user_id) async {
    String url = GETLOCATIONS + TEST;
    Map<String, dynamic> body = {"user_id": user_id.toString()};
    print("url Create User " + url);
    print("body Create User: " + body.toString());
    http.Response response = await RequestMaker().post(url, body, false);
    print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
  }

  static Future<Map<String, dynamic>> getSatelliteInfo(int svid) async {
    String url = GETSATINFO + TEST;
    Map<String, dynamic> body = {"svid": svid.toString()};
    print("url Create User " + url);
    print("body Create User: " + body.toString());
    http.Response response = await RequestMaker().post(url, body, false);
    print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
  }

  static Future<Map<String, dynamic>> getGalileos(int user_id) async {
    String url = GETLGALILEOS + TEST;
    Map<String, dynamic> body = {"user_id": user_id.toString()};
    print("url Create User " + url);
    print("body Create User: " + body.toString());
    http.Response response = await RequestMaker().post(url, body, false);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return jsonData;
  }

  static Future<List<dynamic>> getUserPos(int user_id) async {
    String url = GETUSERPOS + TEST;
    Map<String, dynamic> body = {"user_id": user_id.toString()};
    print("url Create User " + url);

    http.Response response = await RequestMaker().post(url, body, false);
    print("body Create User MAP: " + response.body.toString());
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.toList();
  }

  static Future<List<dynamic>> getGrafic(
      String measurement, String tag, int user_id) async {
    String url = GETUGRAFIC + TEST;
    Map<String, dynamic> body = {
      "measure": "raw",
      "tag": "constellationType",
      "user": "",
    };
    print("url Create User GRAFIC " + url);

    http.Response response = await RequestMaker().post(url, body, false);
    print("body Create User MAP GRAFIC : " + response.body.toString());
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.toList();
  }
}
