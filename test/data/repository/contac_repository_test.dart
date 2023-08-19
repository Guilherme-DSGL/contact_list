import 'package:flutter_test/flutter_test.dart';
import 'package:listacontatos/core/exceptions/exceptions.dart';
import 'package:listacontatos/core/network/network.dart';
import 'package:listacontatos/data/models/contact.dart';
import 'package:listacontatos/data/repository/contact_repository.dart';
import 'package:listacontatos/data/repository/contact_repository_impl.dart';
import 'package:listacontatos/data/source/local/local_source.dart';
import 'package:listacontatos/data/source/remote/remote_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture.dart';
import 'contac_repository_test.mocks.dart';

@GenerateMocks([NetworkInfo, RemoteSource, LocalSource])
main() {
  late MockNetworkInfo mockNetworkInfo;
  late ContactRepository contactRepository;
  late List<Contact> listContact;
  late MockRemoteSource mockRemoteSource;
  late MockLocalSource mockLocalSource;
  late Contact tContact;
  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteSource = MockRemoteSource();
    mockLocalSource = MockLocalSource();
    contactRepository = ContactRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteSource: mockRemoteSource,
        localSource: mockLocalSource);
    listContact = contacts;
    tContact = listContact[4];
  });
  group("Get Contact", () {
    group("When device is connected", () {
      setUp(() {
        when(mockNetworkInfo.isConected).thenAnswer((_) async => true);
      });
      test("Should get contacts from API", () async {
        when(mockRemoteSource.get()).thenAnswer((_) async => listContact);
        final result = await contactRepository.get();
        verify(mockRemoteSource.get());
        expect(result, listContact);
      });

      test("Should throws a exception when get contacts from API", () async {
        when(mockRemoteSource.get()).thenThrow(ServerException());

        final call = contactRepository.get;
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      });

      test("Should save  data in cache", () async {
        when(mockRemoteSource.get()).thenAnswer((_) async => listContact);
        final list = await contactRepository.get();

        verify(mockLocalSource.cache(contact: list));
      });
    });

    group("When device is not connected", () {
      setUp(() {
        when(mockNetworkInfo.isConected).thenAnswer((_) async => false);
      });
      test("Shoul get contacts from Local Source", () async {
        when(mockLocalSource.get()).thenAnswer((_) async => listContact);
        final list = await contactRepository.get();
        verify(mockLocalSource.get());
        expect(list, listContact);
      });

      test("Shoul throws a exception when get contacts from Cache", () {
        when(mockLocalSource.get()).thenThrow(CacheException());

        final call = contactRepository.get;
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      });
    });
  });

  group("Create Contact", () {
    test("Should save contact", () async {
      when(mockRemoteSource.post(body: anyNamed("body")))
          .thenAnswer((_) async => tContact);
      final result = await contactRepository.create(contact: tContact);
      verify(mockRemoteSource.post(body: anyNamed("body")));
      expect(result, tContact);
    });

    test("Should throws a exception when post contact", () async {
      when(mockRemoteSource.post(body: anyNamed("body")))
          .thenThrow(ServerException());

      final call = contactRepository.create;
      expect(() => call(contact: tContact),
          throwsA(const TypeMatcher<ServerException>()));
    });

    test("Should save  data in cache", () async {
      when(mockRemoteSource.get()).thenAnswer((_) async => listContact);
      final list = await contactRepository.get();

      verify(mockLocalSource.cache(contact: list));
    });
  });
}
