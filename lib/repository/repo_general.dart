import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:meme_generator_app/network/api.dart';
import 'package:meme_generator_app/network/response/res_get_meme.dart';
import 'package:http/http.dart' as http;

class RepoGeneral {
  Future<ResGetMeme?> getMeme() async {
    try {
      Response res = await http.get(Uri.parse(Api.memeApi));
      return resGetMemeFromJson(res.body);
    } catch (e, st) {
      if (kDebugMode) {
        log("stack trace: $st");
      }
      log(e.toString());
    }
    return null;
  }
}
