import 'package:rick_and_morty/character_detail/repository_iml/character_detail_respository_iml.dart';

import 'package:rick_and_morty/entities/api_response.dart';
import 'package:rick_and_morty/entities/character_model.dart';
import 'package:rick_and_morty/utils/api_helper.dart';

class CharacterDetailRepository extends CharacterDetailRepositoryIml {
  final ApiBaseHelper apiBaseHelper;

  CharacterDetailRepository(this.apiBaseHelper);

  @override
  Future<ApiResponse> getCharacter(int id) async {
    var response = await apiBaseHelper.getHttp('/api/character/$id');
    if (response.data != null && response.status == 200) {
      response.data = Character.fromJson(response.data);
    }

    return response;
  }
}
