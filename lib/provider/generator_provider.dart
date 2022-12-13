import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class GeneratorProvider extends ChangeNotifier {
  bool isEditText = false;
  bool isEditMode = false;
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController textController = TextEditingController();
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

  void addText(String value) {
    notifyListeners();
  }

  void editDone(BuildContext c, Widget widget) async {
    await screenshotController.captureFromWidget(widget).then((capturedImage) {
      showCapturedWidget(c, capturedImage);
    });
    isEditMode = false;
    notifyListeners();
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
        barrierColor: Colors.white60,
        useSafeArea: false,
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.memory(capturedImage)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      actionButton(onTap: () => saveImage(capturedImage)),
                      actionButton(onTap: () {}, title: "SHARE"),
                    ],
                  )
                ],
              ),
            ));
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    var time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll('.', '-');
    var name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  MaterialButton actionButton({String? title, void Function()? onTap}) =>
      MaterialButton(
        onPressed: onTap,
        color: Colors.grey,
        height: 45,
        child: Text(title ?? "SIMPAN"),
      );
}
