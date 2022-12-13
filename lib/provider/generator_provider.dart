import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class GeneratorProvider extends ChangeNotifier {
  bool isEditText = false;
  bool isEditMode = false;
  XFile? myLogo;

  void editTextVisibilty() {
    isEditMode = true;
    isEditText = !isEditText;
    notifyListeners();
  }

  Future<void> addLogo({bool isFromGallery = true}) async {
    var takeImage = await ImagePicker().pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    isEditMode = true;
    myLogo = XFile(takeImage!.path);
    notifyListeners();
  }

  void editDone() {
    isEditMode = false;
    notifyListeners();
  }
}
