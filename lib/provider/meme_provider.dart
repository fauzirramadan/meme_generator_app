import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meme_generator_app/network/response/res_get_meme.dart';
import 'package:meme_generator_app/repository/repo_general.dart';
import 'package:meme_generator_app/utils/notif_utils.dart';

class MemeProvider extends ChangeNotifier {
  MemeProvider() {
    init();
  }

  final RepoGeneral _repo = RepoGeneral();
  List<Meme> listMeme = [];
  bool isLoading = false;

  void init() {
    getListMeme();
  }

  Future<void> getListMeme() async {
    try {
      isLoading = true;
      notifyListeners();

      ResGetMeme? res = await _repo.getMeme();
      if (res?.success == true) {
        isLoading = false;
        notifyListeners();
        listMeme = res?.data?.memes ?? [];
        log("data meme : $listMeme");
      } else {
        isLoading = false;
        notifyListeners();
        NotificationUtils.showSnackbar("Gagal memeuat data",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log("error prov : $e");
      NotificationUtils.showSnackbar("Gagal memeuat data",
          backgroundColor: Colors.red);
    }
  }
}
