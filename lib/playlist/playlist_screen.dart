import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_parse/dto/track.dart';
import 'package:spotify_parse/playlist/playlist_controller.dart';
import 'package:spotify_parse/your_url_parse/your_url_parse_screen.dart';

class PlaylistScreen extends GetView<PlaylistController> {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Parse'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.to(const YourUrlParseScreen()),
              icon: const Icon(Icons.add))
        ],
      ),
      body: GetBuilder<PlaylistController>(builder: (controller) {
        if (controller.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.status.isSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                    height: 250,
                    child: Image.network(controller.result!.images![0].url!)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            controller.result!.name ?? 'My Playlist',
                            style: const TextStyle(fontSize: 26),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(
                                  width: 120,
                                  child: Text('Name'),
                                ),
                                SizedBox(width: 125, child: Text('Album')),
                                Text('Duration'),
                              ],
                            ),
                          ),
                          ...controller.trackList
                              .map((e) => _buildSongField(e))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _buildSongField(TrackItem track) {
    String minutes = ((track.trackDuration / 60000).floor()).toString();
    String seconds =
        (((track.trackDuration - int.parse(minutes) * 60000) / 1000).floor())
            .toString();
    if (seconds.length == 1) {
      seconds = '0$seconds';
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.name!,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  track.artistList.join(', '),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(width: 125, child: Text(track.album!)),
          Text('${minutes.toString()}:${seconds.toString()}'),
        ],
      ),
    );
  }
}
