import 'package:flutter/material.dart';

class CreatePerson extends StatefulWidget {
  const CreatePerson({super.key});

  @override
  State<CreatePerson> createState() => _CreatePersonState();
}

class _CreatePersonState extends State<CreatePerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Container());
  }
}
