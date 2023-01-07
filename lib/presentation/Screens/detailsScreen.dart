import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beakingbad/businessLogicLayer/cubit/character_cubit.dart';
import 'package:beakingbad/businessLogicLayer/cubit/character_state.dart';
import 'package:beakingbad/constants/my_colors.dart';
import 'package:beakingbad/data/Model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class detailsScreen extends StatelessWidget {
  final CharacterModel character;
  detailsScreen({Key? key, required this.character}) : super(key: key);

  Widget BuildSilverAppBar() {
    return SliverAppBar(
      backgroundColor: myColors.myGrey,
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
        // title: Text(
        //   character.nickname,
        //   style: TextStyle(
        //     color: myColors.myWhite,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        title: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FadeAnimatedText(character.nickname),
            ],
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: TextStyle(
                color: myColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Color.fromARGB(255, 194, 222, 235),
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget characterDivider(double value) {
    return Divider(
      endIndent: value,
      height: 30,
      thickness: 2,
      color: myColors.myYellow,
    );
  }

  Widget getQuoteOrNotFound(CharacterState state) {
    if (state is LoadedQuoteState) {
      return Center(child: displayQuoteOrEmpty(state));
    } else {
      return CircularProgressIndicator(
        color: myColors.myYellow,
      );
    }
  }

  Widget displayQuoteOrEmpty(LoadedQuoteState state) {
    var quotes = (state).quotes;

    if (quotes.length != 0) {
      int randonquote = Random().nextInt(quotes.length - 1);
      return DefaultTextStyle(
        style: TextStyle(
          fontSize: 30.0,
          color: myColors.myWhite,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(quotes[randonquote].quote),
          ],
        ),
      );
      // return Text("quotes[randonquote].quote");
    } else {
      return Container();
    }
  }

//
  @override
  Widget build(BuildContext context) {
    //
    BlocProvider.of<CharacterCubit>(context).getAllQuote(character.name);
    //
    return Scaffold(
      backgroundColor: myColors.myGrey,
      body: CustomScrollView(
        slivers: [
          BuildSilverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        "Job : ",
                        character.occupation.join(" /"),
                      ),
                      characterDivider(280),
                      characterInfo(
                        "Actor/Actors : ",
                        character.name,
                      ),
                      characterDivider(270),
                      //name  appearance portrayed category
                      characterInfo(
                        "Birthday : ",
                        character.bithday,
                      ),
                      characterDivider(240),
                      characterInfo(
                        "status : ",
                        character.status,
                      ),
                      characterDivider(260),
                      characterInfo(
                        "seasons : ",
                        character.appearance.join('/'),
                      ),
                      characterDivider(220),
                      characterInfo(
                        "portrayed : ",
                        character.portrayed,
                      ),
                      characterDivider(235),
                      characterInfo(
                        "category : ",
                        character.categoty,
                      ),
                      characterDivider(240),
                      //
                      character.appearanceInSoul.isEmpty
                          ? Container()
                          : characterInfo(
                              "appearanceInSoul : ",
                              character.appearanceInSoul.join('/'),
                            ),
                      character.appearanceInSoul.isEmpty
                          ? Container()
                          : characterDivider(170),
                      SizedBox(
                        height: 20,
                      ),

                      BlocBuilder<CharacterCubit, CharacterState>(
                          builder: (context, state) {
                        if (state is LoadedQuoteState)
                          return displayQuoteOrEmpty(state);
                        else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: myColors.myYellow,
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
