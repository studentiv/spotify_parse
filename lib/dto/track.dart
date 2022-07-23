class TrackItem {
  String? name;
  int trackDuration;
  String? album;
  List<dynamic> artistList;

  TrackItem(
      {required this.name,
      required this.trackDuration,
      required this.album,
      required this.artistList});
}
