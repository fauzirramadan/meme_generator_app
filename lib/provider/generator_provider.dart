import 'package:flutter/foundation.dart';

class GeneratorProvider extends ChangeNotifier {
  bool isEditText = false;

  void editTextVisibilty() {
    isEditText = !isEditText;
    notifyListeners();
  }
}
