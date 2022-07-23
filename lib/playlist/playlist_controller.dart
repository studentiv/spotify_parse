import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_parse/dto/track.dart';

class PlaylistController extends GetxController {
  RxStatus status = RxStatus.loading();

  late final Playlist? result;
  List<TrackItem> trackList = [];
  List<dynamic>? playlist;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void load() async {
    final credentials = SpotifyApiCredentials(
        '6350a04f9ac34236b2bc8aa2434f61a3', 'dd5a4acbddc44fa8816da20de24dc86f');
    final spotify = SpotifyApi(credentials);

    result = await spotify.playlists.get('3dpOdyAk3AVSSc0CqXQEA6');
    // final album = await spotify.albums.get('1qwlxZTNLe1jq3b0iidlue');
    playlist = result!.tracks!.itemsNative!.toList();
    for (var element in playlist!) {
      trackList.add(TrackItem(
          name: element['track']['name'],
          trackDuration: element['track']['duration_ms'],
          album: element['track']['album']['name'],
          artistList: getList(element['track']['artists'], trackList)));
    }
    status = RxStatus.success();
    update();
  }
}

List<dynamic> getList(List<dynamic> elem, List<TrackItem> trackList) {
  List<dynamic> artistsList = [];

  for (var element in elem) {
    artistsList.add(element['name']);
  }
  return artistsList;
}
