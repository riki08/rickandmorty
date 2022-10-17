import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:rick_and_morty/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_and_morty/characters/bloc/character_bloc.dart';
import 'package:rick_and_morty/characters/characters_page.dart';
import 'package:rick_and_morty/utils/injector.dart';
import 'package:rick_and_morty/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dependencies().repositoryRegister();
  Dependencies().blocsRegister();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => Injector.appInstance.get<CharacterBloc>()),
        BlocProvider(
            create: (_) => Injector.appInstance.get<CharacterDetailBloc>()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: CharactersPage(),
        routes: MyRoutes.routes,
      ),
    );
  }
}
