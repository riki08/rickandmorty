// import 'package:products/products/products_page.dart';
// import 'package:products/products/widgets/form_page.dart';

import 'package:rick_and_morty/character_detail/character_detail_page.dart';
import 'package:rick_and_morty/characters/characters_page.dart';

class MyRoutes {
  static final routes = {
    'characteres': (context) => const CharactersPage(),
    'character_detail': (context) => const CharacterDetailPage(),
  };
}
