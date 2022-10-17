import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character_detail/character_detail_page.dart';
import 'package:rick_and_morty/characters/bloc/character_bloc.dart';
import 'package:rick_and_morty/entities/character_model.dart';
import 'package:rick_and_morty/utils/responsive.dart';
import 'package:rick_and_morty/widgets/loading.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late CharacterBloc characterBloc;
  late ScrollController _scrollController;

  @override
  void initState() {
    characterBloc = BlocProvider.of<CharacterBloc>(context);
    characterBloc.add(GetCharacters());
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    ResponsiveUtil.setScreenSize(size);
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 200.0) {
        characterBloc.add(GetCharacters());
      }
    });
    return Scaffold(
      body:
          BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
        var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 2.2.h);
        if (state.status.isError) {
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/error.png',
                    width: 60.w,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.errorMessage!,
                    style: textStyle,
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                      onPressed: () => characterBloc.add(GetCharacters()),
                      child: Text(
                        'Recargar',
                        style: textStyle.copyWith(fontSize: 2.h),
                      ))
                ],
              ));
        }
        return Column(
          children: [
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 2.5.h),
              color: Colors.grey[300],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'La serie en numeros',
                    style: textStyle,
                  ),
                  Text(
                    '00 numero de episodios',
                    style: textStyle,
                  ),
                  Text(
                    'Locations con mas personajes:',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.characters!.isEmpty
                  ? const Loading()
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 2.h),
                      itemCount: characterBloc.actualPage < 43
                          ? state.characters!.length + 1
                          : state.characters!.length,
                      itemBuilder: (_, int index) {
                        return index >= state.characters!.length
                            ? const Loading()
                            : CardCharacter(
                                character: state.characters![index]);
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class CardCharacter extends StatelessWidget {
  const CardCharacter({
    Key? key,
    required Character character,
  })  : _character = character,
        super(key: key);

  final Character _character;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 2.h);
    return Container(
      height: 12.h,
      margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 0.h),
      child: Row(
        children: [
          FadeInImage.assetNetwork(
              height: 12.h,
              width: 25.w,
              fit: BoxFit.fitHeight,
              placeholderFit: BoxFit.fitHeight,
              placeholder: 'images/loading.gif',
              image: _character.image),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 2.w),
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
              color: Colors.grey[300],
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      _character.name,
                      overflow: TextOverflow.clip,
                      style: textStyle,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 1.h,
                        width: 1.h,
                        margin: EdgeInsets.only(right: 2.w),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      Text(
                        _character.status,
                        style: textStyle.copyWith(fontSize: 1.8.h),
                      ),
                    ],
                  ),
                  Text(
                    _character.species,
                    style: textStyle.copyWith(fontSize: 1.8.h),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CharacterDetailPage(
                                    id: _character.id,
                                  )),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.amber[300],
                            shape: BoxShape.rectangle),
                        child: Text(
                          'Detalle',
                          style: textStyle.copyWith(fontSize: 1.8.h),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
