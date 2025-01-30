import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app1/Controller/data_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // bool loading = false;
  // List<Team> teams = [];
  // Future getTeam() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var response =
  //       await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
  //   var jsondata = jsonDecode(response.body);

  //   for (var eachteam in jsondata) {
  //     final team = Team(title: eachteam['title'], body: eachteam['body']);
  //     teams.add(team);
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   GetData().getTeam();
  // }
  @override
  void initState() {
    super.initState();
    // Fetch data when the page is initialized
    final DataController dataController = Get.put(DataController());
    dataController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());

    return Scaffold(
        body: Column(
      children: [
        Expanded(child: Obx(() {
          if (dataController.loading.value)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView.builder(
              itemCount: dataController.team.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataController.team[index].title),
                  subtitle: Text(dataController.team[index].body),
                );
              },
            );
        }))
      ],
    ));
  }
}
