part of 'character_detail_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetCharacter extends CharacterEvent {
  final int id;

  const GetCharacter(this.id);
}
