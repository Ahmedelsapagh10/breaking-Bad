import 'package:beakingbad/businessLogicLayer/cubit/character_state.dart';
import 'package:beakingbad/data/Model/character_model.dart';
import 'package:beakingbad/data/Model/qouteModel.dart';
import 'package:beakingbad/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCubit extends Cubit<CharacterState> {
  // object from repostory to getAllFunction
  final CharacterRepostory characterRepostory;
  CharacterCubit(this.characterRepostory) : super(initState()) {}
  // this List to store Data of Every character
  List<CharacterModel> characters = [];
  //
  List<CharacterModel> getAllCharacters() {
    characterRepostory.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(LoadedState(characters));
    });
    return characters;
  }

  void getAllQuote(String authorName) {
    characterRepostory
        .getAllQuote(authorName)
        .then((quotes) => emit(LoadedQuoteState(quotes)));
  }
}
