import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'data/data.dart';
import 'pages/home/view/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: multiProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 135)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

final multiProviders = [
  RepositoryProvider<Connectivity>(
    create: (context) => Connectivity(),
  ),
  RepositoryProvider<NetworkInfo>(
    create: (context) => NetWorkInfoConnectivityImp(
      connectivity: context.read<Connectivity>(),
    ),
  ),
  RepositoryProvider<RemoteSource>(
    create: (context) => ContactHttpClient(),
  ),
  RepositoryProvider<LocalSource>(
    create: (context) => ContactSharedPreferences(),
  ),
  RepositoryProvider<ContactRepository>(
    create: (context) => ContactRepositoryImpl(
      networkInfo: context.read<NetworkInfo>(),
      localSource: context.read<LocalSource>(),
      remoteSource: context.read<RemoteSource>(),
    ),
  ),
];
