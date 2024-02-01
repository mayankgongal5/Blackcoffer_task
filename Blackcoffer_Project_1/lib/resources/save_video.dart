import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class StoreData{
  Future<String> uploadVideo(String videoUrl) async{
    Reference ref =_storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadURL=await ref.getDownloadURL();
    return downloadURL;
  }
  Future<void> saveVideoData(String videoDownloadUrl) async{
    await _firestore.collection('videos').add({
      'url': videoDownloadUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'name':  'videos',
    });
  }
}