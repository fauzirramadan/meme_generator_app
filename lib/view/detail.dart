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
                height: 40,
              ),
              Stack(
                  clipBehavior: Clip.none, children: [Image.network(imageUrl)]),
              Visibility(
                  visible: bloc.isEditText,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: "Input Text Here"),
                    ),
                  ))
            ],
          ),
          bottomNavigationBar: Container(
            height: 120,
            color: Colors.grey,
            padding: const EdgeInsets.only(bottom: 20.0, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                attributButton(
                    title: "Add Logo", icon: Icons.image, onTap: null),
                const SizedBox(
                  width: 18,
                ),
                attributButton(
                    title: "Add Text",
                    icon: Icons.text_fields,
                    onTap: () => bloc.editTextVisibilty())
              ],
            ),
          ),
        );
      }),
    );
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
