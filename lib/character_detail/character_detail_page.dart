import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_and_morty/characters/bloc/character_bloc.dart';
import 'package:rick_and_morty/entities/character_model.dart';
import 'package:rick_and_morty/utils/responsive.dart';
import 'package:rick_and_morty/widgets/loading.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key, this.id});

  final int? id;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late CharacterDetailBloc characterBloc;

  @override
  void initState() {
    characterBloc = BlocProvider.of<CharacterDetailBloc>(context);
    characterBloc.add(GetCharacter(widget.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    ResponsiveUtil.setScreenSize(size);
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 2.h);
    return Scaffold(
      body: BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Loading();
          }
          if (state.status.isSuccess) {
            return Center(
              child: Container(
                height: 60.h,
                width: 70.w,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Image.network(state.character!.image,
                          fit: BoxFit.contain, width: 40.w),
                    ),
                    InformationBasic(character: state.character!),
                  ],
                ),
              ),
            );
          } else {
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
                        onPressed: () =>
                            characterBloc.add(GetCharacter(widget.id!)),
                        child: Text(
                          'Recargar',
                          style: textStyle.copyWith(fontSize: 2.h),
                        ))
                  ],
                ));
          }
        },
      ),
    );
  }
}

class InformationBasic extends StatelessWidget {
  const InformationBasic({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 2.h);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(character.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: textStyle.copyWith(
                fontSize: 2.5.h,
              )),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(
                'Especie: ',
                style: textStyle,
              ),
              Text(
                character.species,
                style: textStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Genero: ',
                style: textStyle,
              ),
              Text(
                character.gender,
                style: textStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Estado: ',
                style: textStyle,
              ),
              Text(
                character.status,
                style: textStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Locacion: ',
                style: textStyle,
              ),
              Expanded(
                child: Text(
                  character.location.name,
                  overflow: TextOverflow.clip,
                  style: textStyle.copyWith(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '# episodios: ',
                style: textStyle,
              ),
              Text(
                character.episode.length.toString(),
                style: textStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
