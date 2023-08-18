import '../models/pessoa.dart';

abstract class ContactRepository {
  Future<Contact> create({required Contact contact});
  Future<Contact> get();
}
