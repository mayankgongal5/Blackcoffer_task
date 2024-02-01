import 'package:blackcoffer/Screens/playvideo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('videos').snapshots(),
                  builder: (context, snapshot) {
                    List<Row> videoWidgets = [];
                    if (!snapshot.hasData) {
                      CircularProgressIndicator(color: Colors.black,);
                    } else {
                      final videos = snapshot.data?.docs.reversed.toList();
                      for (var video in videos!) {
                        final videoWidget = Row(
                          children: [
                            Text(video['name']),
                            IconButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                return PlayVideo(videoURL:video['url'] ,videoName:video['name'] ,);
                              }));
                            },
                                icon: Icon(Icons.play_arrow))
                          ],
                        );
                        videoWidgets.add(videoWidget);
                      }
                    }
                    return Expanded(
                        child: ListView(
                      children: videoWidgets,
                    )
                    );
                  }
                  )
            ],
          ),
        ),
      ),
    );
  }
}
