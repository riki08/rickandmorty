import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/characters/repository_iml/character_respository_iml.dart';
import 'package:rick_and_morty/entities/character_model.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepositoryIml characterRepositoryIml;
  final int maxPage = 42;

  int actualPage = 0;
  List<Character> totalCharacter = [];
  CharacterBloc(this.characterRepositoryIml) : super(CharacterState()) {
    on<GetCharacters>(_getCharacter);
  }

  Future<void> _getCharacter(
      GetCharacters event, Emitter<CharacterState> emit) async {
    actualPage = actualPage + 1;
    if (actualPage < 43) {
      emit(state.copyWith(status: CharacterStatus.loading));

      try {
        final apiResult =
            await characterRepositoryIml.getCharacters(actualPage);

        if (apiResult.data != null) {
          totalCharacter.addAll(apiResult.data);

          emit(state.copyWith(
              status: CharacterStatus.success, characters: totalCharacter));
        } else {
          actualPage = actualPage - 1;
          emit(state.copyWith(
            status: CharacterStatus.error,
            errorMessage: apiResult.message,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: CharacterStatus.error,
          errorMessage: e.toString(),
        ));
      }
    }
  }
}
