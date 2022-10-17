import 'package:rick_and_morty/entities/api_response.dart';

abstract class CharacterDetailRepositoryIml {
  Future<ApiResponse> getCharacter(int id);
}
