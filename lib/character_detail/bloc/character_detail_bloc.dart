import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character_detail/repository_iml/character_detail_respository_iml.dart';
import 'package:rick_and_morty/characters/repository_iml/character_respository_iml.dart';
import 'package:rick_and_morty/entities/character_model.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterDetailBloc extends Bloc<CharacterEvent, CharacterDetailState> {
  final CharacterDetailRepositoryIml characterDetailRepositoryIml;
  CharacterDetailBloc(this.characterDetailRepositoryIml)
      : super(CharacterDetailState()) {
    on<GetCharacter>(_getCharacter);
  }

  Future<void> _getCharacter(
      GetCharacter event, Emitter<CharacterDetailState> emit) async {
    emit(state.copyWith(status: CharacterDetailStatus.loading));
    try {
      final apiResult =
          await characterDetailRepositoryIml.getCharacter(event.id);

      if (apiResult.data != null) {
        emit(state.copyWith(
            status: CharacterDetailStatus.success, character: apiResult.data));
      } else {
        emit(state.copyWith(
          status: CharacterDetailStatus.error,
          errorMessage: apiResult.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CharacterDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
