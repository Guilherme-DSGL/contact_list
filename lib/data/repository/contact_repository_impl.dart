// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:listacontatos/data/models/contact.dart';
import 'package:listacontatos/data/source/remote/remote_source.dart';

import '../../core/network/network_info/network_info.dart';
import '../source/local/local_source.dart';
import 'contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;
  final LocalSource _localSource;
  ContactRepositoryImpl(
      {required NetworkInfo networkInfo,
      required RemoteSource remoteSource,
      required LocalSource localSource})
      : _networkInfo = networkInfo,
        _remoteSource = remoteSource,
        _localSource = localSource;

  @override
  Future<Contact> create({required Contact contact}) {
    final result = _remoteSource.post(body: contact);
    return result;
  }

  @override
  Future<List<Contact>> get() async {
    if (await _networkInfo.isConected) {
      final result = await _remoteSource.get();
      _localSource.cache(contact: result);
      return result;
    } else {
      return _localSource.get();
    }
  }
}
