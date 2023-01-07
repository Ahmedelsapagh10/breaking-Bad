import 'package:beakingbad/data/Model/character_model.dart';
import 'package:beakingbad/data/Model/qouteModel.dart';

abstract class CharacterState {}

class initState extends CharacterState {}

class LoadedState extends CharacterState {
  final List<CharacterModel> characters;
  LoadedState(this.characters);
}

class LoadedQuoteState extends CharacterState {
  final List<Quote> quotes;
  LoadedQuoteState(this.quotes);
}
