import 'dart:io';

import 'package:blackcoffer/Screens/video_list.dart';
import 'package:flutter/material.dart';
import 'package:blackcoffer/util.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blackcoffer/resources/save_video.dart';
import 'package:flutter/foundation.dart'show kIsWeb;
import 'package:video_player_web/video_player_web.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIdeo Upload'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VideoList()));
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: Center(
          child:
              _videoURL != null ? _videoPreview() : Text('No video Selected')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: _pickVideo,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializedVideoPlayer();
  }

  void _initializedVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
  }

  Widget _videoPreview() {
    if (_controller != null) {
      return Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(onPressed: _uploadVideo, child: Text('Upload')),
          )
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  void _uploadVideo() async {
    _downloadURL = await StoreData().uploadVideo(_videoURL!);
    await StoreData().saveVideoData(_downloadURL!);
    setState(() {
      _videoURL = null;
    });
  }
}
