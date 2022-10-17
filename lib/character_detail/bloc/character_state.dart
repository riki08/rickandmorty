part of 'character_detail_bloc.dart';

enum CharacterDetailStatus { initial, loading, success, error }

extension CharacterDetailStatusX on CharacterDetailStatus {
  bool get isInitial => this == CharacterDetailStatus.initial;
  bool get isSuccess => this == CharacterDetailStatus.success;
  bool get isError => this == CharacterDetailStatus.error;
  bool get isLoading => this == CharacterDetailStatus.loading;
}

class CharacterDetailState extends Equatable {
  CharacterDetailState({
    this.status = CharacterDetailStatus.initial,
    this.errorMessage = '',
    this.character,
  });

  final Character? character;
  final CharacterDetailStatus status;
  final String? errorMessage;

  CharacterDetailState copyWith({
    CharacterDetailStatus? status,
    String? errorMessage,
    Character? character,
  }) =>
      CharacterDetailState(
          status: status ?? this.status,
          character: character ?? this.character,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [status, character, errorMessage];
}
