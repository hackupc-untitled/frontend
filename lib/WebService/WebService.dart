import 'RequestMaker.dart';

class WebService {
  static final HOST = "http://192.168.151.11:5000/test";
  static final TEST = "";

  static Future<String> send(String measurement, Map<String, dynamic> tags,
      Map<String, dynamic> fields) async {
    String url = HOST + TEST;
    Map<String, dynamic> body = {
      "measurement": measurement,
      "tags": tags,
      "fields": fields
    };
    print("url Create User " + url);
    print("body Create User: " + body.toString());
    RequestMaker().post(url, body, false);
    return "a";
  }
}
