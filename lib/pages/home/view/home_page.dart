import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listacontatos/data/repository/repository.dart';
import 'package:listacontatos/pages/home/view/home_list.dart';

import '../../create_person/create_person.dart';
import '../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(context.read<ContactRepository>()),
        child: const HomeList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const CreatePerson(),
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
