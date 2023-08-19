import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listacontatos/core/exceptions/exceptions.dart';
import 'package:listacontatos/data/models/contact.dart';

import 'remote_source.dart';

const kApiUrl = 'someApi';

class ContactHttpClient implements RemoteSource {
  @override
  Future<List<Contact>> get() async {
    final url = Uri.parse(kApiUrl);
    final res =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      final list = jsonDecode(res.body)["results"] as List;
      return list.map((e) => Contact.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Contact> post({required Contact body}) async {
    final url = Uri.parse(kApiUrl);
    final res = await http.post(url, body: body);

    return Contact.fromJson(res.body);
  }
}
