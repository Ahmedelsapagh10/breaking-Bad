//repository receive data from webservices and map to it
import 'package:beakingbad/data/Model/qouteModel.dart';
import 'package:beakingbad/data/web_services/character_web_services.dart';

import '../Model/character_model.dart';

class CharacterRepostory {
  //object from WebServices TO use GetAllFunction

  final CharacterWebServices characterWebServices;
  CharacterRepostory(
    this.characterWebServices,
  );

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }

//get all quotes
  Future<List<Quote>> getAllQuote(String authorName) async {
    final quotes = await characterWebServices.getAllQuote(authorName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
