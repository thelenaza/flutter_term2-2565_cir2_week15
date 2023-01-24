import 'package:flutter/material.dart';

import 'screen/dashboard.dart';
import 'signin.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}
