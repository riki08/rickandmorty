part of 'character_bloc.dart';

enum CharacterStatus { initial, loading, success, error }

extension CharacterStatusX on CharacterStatus {
  bool get isInitial => this == CharacterStatus.initial;
  bool get isSuccess => this == CharacterStatus.success;
  bool get isError => this == CharacterStatus.error;
  bool get isLoading => this == CharacterStatus.loading;
}

class CharacterState extends Equatable {
  CharacterState({
    this.status = CharacterStatus.initial,
    this.errorMessage = '',
    List<Character>? characters,
  }) : characters = characters ?? [];

  final List<Character>? characters;
  final CharacterStatus status;
  final String? errorMessage;

  CharacterState copyWith({
    CharacterStatus? status,
    String? errorMessage,
    List<Character>? characters,
  }) =>
      CharacterState(
          status: status ?? this.status,
          characters: characters ?? this.characters,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [status, characters, errorMessage];
}
