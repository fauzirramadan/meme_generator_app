// To parse this JSON data, do
//
//     final resGetMeme = resGetMemeFromJson(jsonString);

import 'dart:convert';

ResGetMeme resGetMemeFromJson(String str) =>
    ResGetMeme.fromJson(json.decode(str));

String resGetMemeToJson(ResGetMeme data) => json.encode(data.toJson());

class ResGetMeme {
  ResGetMeme({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory ResGetMeme.fromJson(Map<String, dynamic> json) => ResGetMeme(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.memes,
  });

  List<Meme>? memes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        memes: json["memes"] == null
            ? null
            : List<Meme>.from(json["memes"].map((x) => Meme.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "memes": memes == null
            ? null
            : List<dynamic>.from(memes!.map((x) => x.toJson())),
      };
}

class Meme {
  Meme({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
    this.captions,
  });

  String? id;
  String? name;
  String? url;
  int? width;
  int? height;
  int? boxCount;
  int? captions;

  factory Meme.fromJson(Map<String, dynamic> json) => Meme(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
        boxCount: json["box_count"],
        captions: json["captions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "width": width,
        "height": height,
        "box_count": boxCount,
        "captions": captions,
      };
}
