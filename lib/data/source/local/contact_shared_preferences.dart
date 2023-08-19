import 'package:listacontatos/core/exceptions/exceptions.dart';
import 'package:listacontatos/data/models/contact.dart';
import 'package:listacontatos/data/source/local/local_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kContact = "CACHE_CONTACT_KEY";

class ContactSharedPreferences implements LocalSource {
  @override
  Future<void> cache({required List<Contact> contact}) async {
    final shared = await SharedPreferences.getInstance();
    final stringList = contact.map((e) => e.toJson()).toList();
    final result = await shared.setStringList(kContact, stringList);
    if (!result) {
      throw CacheException();
    }
  }

  @override
  Future<List<Contact>> get() async {
    final shared = await SharedPreferences.getInstance();
    final result = shared.getStringList(kContact);
    if (result != null) {
      return result.map((e) => Contact.fromJson(e)).toList();
    }
    throw CacheException();
  }
}
