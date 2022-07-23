import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_parse/global_binding.dart';
import 'package:spotify_parse/playlist/playlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const PlaylistScreen(),
      initialBinding: GlobalBinding(),
    );
  }
}
