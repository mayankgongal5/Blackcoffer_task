import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

pickVideo() async {
  final picker = ImagePicker();
  XFile? videoFile;
  try {
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile!.path;
  } catch (e) {
    print('Video error in picking: $e');
  }
}
