part of './home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final List<Contact> contacts;
  final HomeStatus status;
  final String? erroMessage;
  const HomeState._({
    required this.status,
    this.erroMessage,
    required this.contacts,
  });

  HomeState.initial()
      : this._(
          contacts: _contacts,
          status: HomeStatus.initial,
        );

  @override
  List<Object?> get props => [status, erroMessage, contacts];

  HomeState copyWith({
    HomeStatus? status,
    String? erroMessage,
    List<Contact>? contacts,
  }) {
    return HomeState._(
      status: status ?? this.status,
      erroMessage: erroMessage ?? this.erroMessage,
      contacts: contacts ?? this.contacts,
    );
  }
}

//For tests UI
List<Contact> _contacts = [
  const Contact(name: "Guilherme", phone: "(88) 99856-9514"),
  const Contact(name: "Guilherme", phone: "(88) 99856-9514"),
  const Contact(name: "Ana", phone: "(99) 12345-6789"),
  const Contact(name: "Carlos", phone: "(77) 98765-4321"),
  const Contact(name: "Mariana", phone: "(66) 55555-1234"),
  const Contact(name: "Pedro", phone: "(55) 77777-8888"),
  const Contact(name: "Isabela", phone: "(44) 22222-3333"),
  const Contact(name: "Luis", phone: "(33) 44444-5555"),
  const Contact(name: "Fernanda", phone: "(22) 66666-7777"),
  const Contact(name: "Rafael", phone: "(11) 11111-2222"),
  const Contact(name: "Sofia", phone: "(00) 99999-0000"),
  const Contact(name: "Gustavo", phone: "(99) 88888-7777"),
  const Contact(name: "Amanda", phone: "(88) 77777-6666"),
  const Contact(name: "Lucas", phone: "(77) 66666-5555"),
  const Contact(name: "Juliana", phone: "(66) 55555-4444"),
];
