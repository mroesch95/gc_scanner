import 'package:http/http.dart' as http;

abstract class ApiBaseService {
  int acceptedStatusCode = 200;

  Future<dynamic> getData(String url) async {
    dynamic jsonData;
    var client = http.Client();
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == acceptedStatusCode) {
        jsonData = response.body;
      }
    } catch (e) {
      print(e);
    }
    client.close();
    return jsonData;
  }
}
