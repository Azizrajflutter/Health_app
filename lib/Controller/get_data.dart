import 'dart:convert';

import 'package:get/get.dart';
import 'package:health_app1/Model/team.dart';
import 'package:http/http.dart' as http;

class GetData extends GetxController {
  bool loading = false;
  List<Team> _teams = [];

  List<Team> get teams => _teams;

  Future getTeam() async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');

    loading = true;

    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var jsondata = jsonDecode(response.body);

    loading = false;
    for (var eachteam in jsondata) {
      final team = Team(title: eachteam['title'], body: eachteam['body']);
      _teams.add(team);
    }
  }
}

/////////////////////////////////////////
///
///

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
