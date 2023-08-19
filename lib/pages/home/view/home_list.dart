import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  void initState() {
    context.read<HomeCubit>().fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.erroMessage ?? 'Failhou ao resgatar'),
              ),
            );
        }
      },
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.contacts.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text(state.contacts[index].name),
                  subtitle: Text(state.contacts[index].phone),
                  trailing: const Icon(Icons.phone),
                ),
              );
            });
      },
    );
  }
}
