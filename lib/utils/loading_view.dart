import 'package:flutter/material.dart';

Widget get loadingView => const Center(
      child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: CircularProgressIndicator(
            color: Colors.black,
          )),
    );
