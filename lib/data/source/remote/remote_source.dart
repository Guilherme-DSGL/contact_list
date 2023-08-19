import '../../models/contact.dart';

abstract class RemoteSource {
  Future<List<Contact>> get();
  Future<Contact> post({required Contact body});
}
