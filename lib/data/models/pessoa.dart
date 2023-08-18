import 'dart:convert';

import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String name;
  final String phone;
  const Contact({
    required this.name,
    required this.phone,
  });

  Contact copyWith({
    String? name,
    String? phone,
  }) {
    return Contact(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Contact(name: $name, phone: $phone)';

  @override
  List<Object?> get props => [name, phone];
}
