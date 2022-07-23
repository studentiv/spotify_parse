import 'package:get/get.dart';
import 'package:spotify_parse/playlist/playlist_controller.dart';
import 'package:spotify_parse/your_url_parse/your_url_parse_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaylistController(), fenix: true);
    Get.lazyPut(() => YourUrlParseController(), fenix: true);
  }
}
