import 'package:listacontatos/data/models/contact.dart';

abstract class LocalSource {
  Future<void> cache({required List<Contact> contact});
  Future<List<Contact>> get();
}
