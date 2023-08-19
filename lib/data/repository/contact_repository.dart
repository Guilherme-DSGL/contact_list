import '../models/contact.dart';

abstract class ContactRepository {
  Future<Contact> create({required Contact contact});
  Future<List<Contact>> get();
}
