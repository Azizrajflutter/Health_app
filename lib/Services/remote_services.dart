import 'dart:convert';
import 'package:health_app1/Model/data_controller.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var cleint = http.Client();
  static Future<List<Welcome>?> fetchData() async {
    var response =
        await cleint.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    if (response.statusCode == 200) {
      String JsonString = response.body;

      var data = jsonDecode(JsonString);

      List<Welcome> dataModel = [];

      // dataModel.addAll(data.map((e) => Welcome.fromJson(e)));
      dataModel.addAll(data.map((e) => Welcome.fromJson(e)).cast<Welcome>());

      return dataModel;

      // return welcomeFromJson(JsonString);
    } else {
      return null;
    }
  }
}
