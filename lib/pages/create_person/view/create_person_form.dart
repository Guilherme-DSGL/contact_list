import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/create_person_cubit.dart';

class CreatePersonForm extends StatelessWidget {
  CreatePersonForm({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocListener<CreatePersonCubit, CreatePersonState>(
      listener: (context, state) {
        if (state.status == CreatePersonStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.erroMessage ?? 'Failhou ao cadastrar'),
              ),
            );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 16),
                    const _NameInput(),
                    const SizedBox(height: 8),
                    const _PhoneInput(),
                    const SizedBox(height: 8),
                    _ButtonSubmission(
                        validate: () =>
                            _formKey.currentState?.validate() ?? false),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePersonCubit, CreatePersonState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: context.read<CreatePersonCubit>().nameOnChanged,
          enabled: state.status != CreatePersonStatus.loading,
          decoration: const InputDecoration(
            labelText: 'Name',
            helperText: '',
          ),
          validator: (name) {
            if (name == null) {
              return "Name is required";
            } else if (name.length < 6) {
              return "Name  is too short";
            }
            return null;
          },
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePersonCubit, CreatePersonState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: context.read<CreatePersonCubit>().phoneOnChanged,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          enabled: state.status != CreatePersonStatus.loading,
          decoration: const InputDecoration(
            labelText: 'Phone',
            helperText: '',
          ),
          validator: (name) {
            if (name == null) {
              return "Phone is required";
            } else if (name.length < 6) {
              return "Phone  is too short";
            }
            return null;
          },
        );
      },
    );
  }
}

class _ButtonSubmission extends StatelessWidget {
  const _ButtonSubmission({required this.validate});
  final bool Function() validate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePersonCubit, CreatePersonState>(
      builder: (context, state) {
        if (state.status == CreatePersonStatus.loading) {
          return const CircularProgressIndicator();
        } else {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (validate()) {
                          context.read<CreatePersonCubit>().create();
                        }
                      },
                      child: const Text("Enviar")),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
