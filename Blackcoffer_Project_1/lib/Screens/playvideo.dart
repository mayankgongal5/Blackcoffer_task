import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key? key, required this.videoURL, required this.videoName}):super(key:key);
  final String videoURL;
  final String videoName;


  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
 late VideoPlayerController _controller;
 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
   _controller=VideoPlayerController.networkUrl(Uri.parse(widget.videoURL));
   _controller.setLooping(true);
   _controller.initialize().then((_) => setState((){}));
   _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Video'),

      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller) ,
              
              ),
            ),
            SizedBox(height: 40,),
            Text(widget.videoName)
          ],
        ),

      ),
    );
  }
}
