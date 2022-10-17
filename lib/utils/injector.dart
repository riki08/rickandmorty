import 'package:injector/injector.dart';
import 'package:rick_and_morty/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_and_morty/character_detail/repository/character_detail_repository.dart';
import 'package:rick_and_morty/character_detail/repository_iml/character_detail_respository_iml.dart';
import 'package:rick_and_morty/characters/bloc/character_bloc.dart';
import 'package:rick_and_morty/characters/repository/character_repository.dart';
import 'package:rick_and_morty/characters/repository_iml/character_respository_iml.dart';

import 'package:rick_and_morty/utils/api_helper.dart';

class Dependencies {
  final injector = Injector.appInstance;

  blocsRegister() {
    injector.registerSingleton<CharacterBloc>(
        () => CharacterBloc(injector.get<CharacterRepositoryIml>()));
    injector.registerSingleton<CharacterDetailBloc>(() =>
        CharacterDetailBloc(injector.get<CharacterDetailRepositoryIml>()));
  }

  repositoryRegister() {
    injector.registerSingleton<ApiBaseHelper>(() => ApiBaseHelper());

    injector.registerDependency<CharacterRepositoryIml>(
        () => CharacterRepository(injector.get<ApiBaseHelper>()));
    injector.registerDependency<CharacterDetailRepositoryIml>(
        () => CharacterDetailRepository(injector.get<ApiBaseHelper>()));
  }
}
