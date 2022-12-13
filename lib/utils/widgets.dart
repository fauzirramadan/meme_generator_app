import 'package:flutter/material.dart';

Widget get loadingView => const Center(
      child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: CircularProgressIndicator(
            color: Colors.black,
          )),
    );

var myAppBar = AppBar(
  elevation: 0,
  backgroundColor: Colors.grey[400],
  centerTitle: true,
  title: const Text(
    "MimGenerator",
    style: TextStyle(color: Colors.black),
  ),
);
