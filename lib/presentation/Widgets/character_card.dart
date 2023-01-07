import 'package:beakingbad/constants/my_colors.dart';
import 'package:beakingbad/data/Model/character_model.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, detailsCharacterScreen,
          arguments: character),
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(2),
          padding: EdgeInsetsDirectional.all(4),
          decoration: BoxDecoration(
            color: myColors.myYellow,
            border: Border.all(width: 1, color: myColors.myWhite),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridTile(
            // ignore: sort_child_properties_last
            child: Hero(
              tag: character.id,
              child: Container(
                  child: character.image.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/1.gif',
                          image: character.image)
                      : Image.asset(
                          'assets/images/00.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )),
            ),
            footer: Container(
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                character.name,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: myColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}
