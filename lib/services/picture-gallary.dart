import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUploadServiceGallery {
  final String? bcketName; // Make studentName nullable using '?'

  ImageUploadServiceGallery({this.bcketName ='profilePics'});
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String path) async {
    try {
      final imageFile = File(path);
      final croppedImage = await _cropImage(imageFile);
      final imageName = '${DateTime.now()}.jpg'; // Unique name
      final uploadTask = _storage
          .ref()
          .child(bcketName!)
          .child(imageName)
          .putFile(File(croppedImage.path));

      final snapshot = await uploadTask.whenComplete(() => null);
      final urlI = await snapshot.ref.getDownloadURL();
      
      return urlI;
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<dynamic> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 80,
      compressFormat: ImageCompressFormat.jpg,
    );
    return croppedFile;
  }

  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageString = await uploadImage(pickedFile.path);
      return imageString;
    } else {
      return null;
    }
  }
}
