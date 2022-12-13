import 'package:flutter/material.dart';
import 'package:meme_generator_app/provider/meme_provider.dart';
import 'package:meme_generator_app/utils/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../network/response/res_get_meme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemeProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "MimGenerator",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Consumer<MemeProvider>(builder: (context, bloc, _) {
          return bloc.isLoading
              ? loadingView
              : SmartRefresher(
                  controller: _refreshController,
                  header: const WaterDropMaterialHeader(
                    backgroundColor: Colors.grey,
                    color: Colors.black,
                  ),
                  enablePullDown: true,
                  onRefresh: () {
                    bloc.init();
                    _refreshController.loadComplete();
                  },
                  onLoading: () => loadingView,
                  child: GridView.builder(
                      itemCount: bloc.listMeme.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2.5,
                              mainAxisSpacing: 2.5),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Center(
                              child: Image.network(
                                "${bloc.listMeme[index].url}",
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return loadingView;
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                );
        }),
      ),
    );
  }
}
