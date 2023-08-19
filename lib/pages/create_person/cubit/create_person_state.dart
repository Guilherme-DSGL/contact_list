part of './create_person_cubit.dart';

enum CreatePersonStatus { initial, loading, loaded, error }

class CreatePersonState extends Equatable {
  final String name;
  final String phone;
  final CreatePersonStatus status;
  final String? erroMessage;
  const CreatePersonState._({
    required this.status,
    this.erroMessage,
    required this.name,
    required this.phone,
  });

  const CreatePersonState.initial()
      : this._(name: "", phone: "", status: CreatePersonStatus.initial);

  @override
  List<Object?> get props => [status, erroMessage, name, phone];

  CreatePersonState copyWith({
    CreatePersonStatus? status,
    String? erroMessage,
    String? name,
    String? phone,
  }) {
    return CreatePersonState._(
      status: status ?? this.status,
      erroMessage: erroMessage ?? this.erroMessage,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
