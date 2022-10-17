import 'package:rick_and_morty/entities/api_response.dart';

abstract class CharacterRepositoryIml {
  Future<ApiResponse> getCharacters(int page);
}
