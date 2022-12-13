import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator_app/provider/generator_provider.dart';
import 'package:meme_generator_app/utils/widgets.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;
  const DetailPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneratorProvider(),
      child: Consumer<GeneratorProvider>(builder: (context, bloc, _) {
        return Scaffold(
          appBar: myAppBar,
          body: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: bloc.isEditMode,
                child: TextButton(
                  onPressed: () =>
                      bloc.editDone(context, memeImage(bloc, context)),
                  child: const Text(
                    "Generate Meme",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              memeImage(bloc, context),
              Visibility(
                visible: bloc.isEditText,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: bloc.textController,
                    onChanged: (val) => bloc.addText(val),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Input Text Here"),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar:
              Consumer<GeneratorProvider>(builder: (context, bloc, _) {
            return Container(
              height: 110,
              padding: const EdgeInsets.only(bottom: 20.0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  attributButton(
                      title: "Add Logo",
                      icon: Icons.image,
                      onTap: () {
                        myBottomSheet(context, bloc);
                      }),
                  const SizedBox(
                    width: 18,
                  ),
                  attributButton(
                      title: "Add Text",
                      icon: Icons.text_fields,
                      onTap: () => bloc.editTextVisibilty())
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  Stack memeImage(GeneratorProvider bloc, BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Image.network(imageUrl),
      bloc.myLogo != null
          ? Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width / 5,
              child: SizedBox(
                height: 100,
                child: ClipOval(
                  child: Image.file(
                    File(bloc.myLogo!.path),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      Positioned(
          top: 10,
          left: MediaQuery.of(context).size.width / 2.3,
          child: Text(
            bloc.textController.text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ))
    ]);
  }

  Future<dynamic> myBottomSheet(BuildContext context, GeneratorProvider bloc) {
    return showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () => bloc.addLogo(isFromGallery: false),
                    title: const Text("Camera"),
                    trailing: const Icon(Icons.camera),
                  ),
                  ListTile(
                    onTap: () => bloc.addLogo(),
                    title: const Text("Gallery"),
                    trailing: const Icon(Icons.image),
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget attributButton({String? title, IconData? icon, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 8,
        ),
        Icon(
          icon,
          size: 50,
        ),
      ],
    ),
  );
}
