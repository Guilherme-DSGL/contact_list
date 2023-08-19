import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listacontatos/data/repository/repository.dart';

import '../../../data/models/contact.dart';

part './create_person_state.dart';

class CreatePersonCubit extends Cubit<CreatePersonState> {
  final ContactRepository contactRepository;
  CreatePersonCubit(this.contactRepository)
      : super(const CreatePersonState.initial());

  void nameOnChanged(String name) {
    emit(state.copyWith(name: name));
    log("Name changed ${state.name}");
  }

  void phoneOnChanged(String phone) {
    emit(state.copyWith(phone: phone));
    log("Phone Changed ${state.phone}");
  }

  create() async {
    try {
      emit(state.copyWith(status: CreatePersonStatus.loading));
      await contactRepository.create(
          contact: Contact(name: state.name, phone: state.phone));
      emit(state.copyWith(status: CreatePersonStatus.loaded));
    } catch (e) {
      log("$e");
      emit(state.copyWith(
          status: CreatePersonStatus.error,
          erroMessage: "Error ao criar Contato"));
    }
  }
}
