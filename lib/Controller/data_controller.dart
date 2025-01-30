import 'package:get/state_manager.dart';
import 'package:health_app1/Services/remote_services.dart';

class DataController extends GetxController {
  var team = [].obs;
  var loading = true.obs;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    loading(true);
    try {
      var data = await RemoteServices.fetchData();
      if (data != null) {
        team.value = data;
      }
    } finally {
      loading(false);
      // TODO
    }
  }
}
