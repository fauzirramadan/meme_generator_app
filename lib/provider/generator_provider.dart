import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator_app/utils/nav_utils.dart';
import 'package:meme_generator_app/utils/notif_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

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
                      actionButton(onTap: () async {
                        await saveImage(capturedImage);
                        NotificationUtils.showSnackbar(
                            "BERHASIL MENYIMPAN GAMBAR",
                            backgroundColor: Colors.green);
                        Nav.back();
                      }),
                      actionButton(
                        title: "SHARE",
                        onTap: () => saveAndShare(capturedImage),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = await File('${directory.path}/meme.png').create();
    image.writeAsBytesSync(bytes);

    await Share.shareXFiles([XFile(image.path)]);
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
