import 'package:rick_and_morty/characters/repository_iml/character_respository_iml.dart';
import 'package:rick_and_morty/entities/api_response.dart';
import 'package:rick_and_morty/entities/character_model.dart';
import 'package:rick_and_morty/utils/api_helper.dart';

class CharacterRepository extends CharacterRepositoryIml {
  final ApiBaseHelper apiBaseHelper;

  CharacterRepository(this.apiBaseHelper);

  @override
  Future<ApiResponse> getCharacters(int page) async {
    var response = await apiBaseHelper.getHttp('/api/character/?page=$page');
    if (response.data != null && response.status == 200) {
      response.data = (response.data['results'] as List)
          .map((e) => Character.fromJson(e))
          .toList();
    }

    return response;
  }
}
