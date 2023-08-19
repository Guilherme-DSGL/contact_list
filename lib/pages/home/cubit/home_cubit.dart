import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listacontatos/data/repository/repository.dart';

import '../../../data/models/contact.dart';

part './home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ContactRepository contactRepository;
  HomeCubit(this.contactRepository) : super(HomeState.initial());

  Future<void> fetch() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final contacts = await contactRepository.get();
      emit(state.copyWith(status: HomeStatus.loaded, contacts: contacts));
    } catch (e) {
      log("$e");
      emit(state.copyWith(
          status: HomeStatus.error,
          erroMessage: "Erro when fetching contacts"));
    }
  }
}
