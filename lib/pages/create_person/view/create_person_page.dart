import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listacontatos/pages/create_person/cubit/create_person_cubit.dart';

import '../../../data/data.dart';
import 'create_person_form.dart';

class CreatePerson extends StatefulWidget {
  const CreatePerson({
    super.key,
  });

  @override
  State<CreatePerson> createState() => _CreatePersonState();
}

class _CreatePersonState extends State<CreatePerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Person Screen"),
        ),
        body: BlocProvider(
          create: (context) =>
              CreatePersonCubit(context.read<ContactRepository>()),
          child: CreatePersonForm(),
        ));
  }
}
