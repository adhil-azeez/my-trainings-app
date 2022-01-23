import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const String route = "/test_screen";

  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? text;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TestScreen"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(),
        child: const SingleChildScrollView(),
      ),
    );
  }
}
