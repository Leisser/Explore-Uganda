import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadServiceMultipleGallarey {
  final String? bcketName; // Make studentName nullable using '?'

  ImageUploadServiceMultipleGallarey({this.bcketName = 'profilePics'});
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final List<String> imagelist = [];

  Future<String?> uploadImage(String path) async {
    try {
      final imageFile = File(path);
      // final croppedImage = await _cropImage(imageFile);
      final imageName = '${DateTime.now()}.jpg'; // Unique name
      final uploadTask =
          _storage.ref().child(bcketName!).child(imageName).putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();

      return url;
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Future<dynamic> _cropImage(File imageFile) async {
  //   final croppedFile = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //     compressQuality: 80,
  //     compressFormat: ImageCompressFormat.jpg,
  //   );
  //   return croppedFile;
  // }

  Future<List<String?>> pickImage() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    for (var i in images) {
      final imageString = await uploadImage(i.path);
      imagelist.add(imageString!);
    }
    return imagelist;
  }
}
