import 'package:scanner/constants/strings.dart';
import 'package:scanner/models/login.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class LoginService extends ApiBaseService {
  Future<Login> getLogin() async {
    dynamic loginJson = await getData(Strings.login_url);
    print('Result = > ' + loginJson.toString());
    if (loginJson.toString() != 'false') {
      final Login login = loginFromJson(loginJson);
      return login;
    } else {
      return Login(username: '', password: '');
    }
  }

  // für Testzwecke da die Funktion oft im code benutzt wird
  Future<Login> getLogin1(http.Client client) async {
    dynamic jsonData;
    try {
      var response = await client.get(Uri.parse(Strings.login_url));
      if (response.statusCode == acceptedStatusCode) {
        jsonData = response.body;
      }
    } catch (e) {
      print('e = > ' + e.toString());
      return Login(username: "", password: "");
    }
    client.close();
    //return jsonData;
    final Login login = loginFromJson(jsonData);
    return login;
  }
}
