import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_parse/dto/track.dart';

class YourUrlParseController extends GetxController {
  RxStatus status = RxStatus.empty();
  late final SpotifyApi spotify;

  String url = '';

  dynamic result;
  List<TrackItem> trackList = [];
  List<dynamic>? playlist;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void load() {
    final credentials = SpotifyApiCredentials(
        '6350a04f9ac34236b2bc8aa2434f61a3', 'dd5a4acbddc44fa8816da20de24dc86f');
    spotify = SpotifyApi(credentials);
  }

  void setUrl(String value) {
    url = value;
  }

  void parse() async {
    url = url.split('/').last;

    try {
      result = await spotify.playlists.get(url);
      parsePlaylist();
      status = RxStatus.success();
      update();
    } catch (e) {
      try {
        result = await spotify.albums.get(url);
        playlist = result.tracks!.toList();
        for (var element in playlist!) {
          trackList.add(TrackItem(
              name: element.name,
              trackDuration: element.duration.inMilliseconds,
              album: null,
              artistList: getList(element.artists, false)));
          status = RxStatus.success();
          update();
        }
      } catch (e) {
        status = RxStatus.error();
        update();
      }
    }
  }

  void parsePlaylist() {
    playlist = result!.tracks!.itemsNative!.toList();
    for (var element in playlist!) {
      trackList.add(TrackItem(
          name: element['track']['name'],
          trackDuration: element['track']['duration_ms'],
          album: element['track']['album']['name'],
          artistList: getList(element['track']['artists'], true)));
    }
  }

  List<dynamic> getList(List<dynamic> elem, bool isPlaylist) {
    List<dynamic> artistsList = [];

    for (var element in elem) {
      isPlaylist
          ? artistsList.add(element['name'])
          : artistsList.add(element.name);
    }
    return artistsList;
  }
}
