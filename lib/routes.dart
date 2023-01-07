import 'package:beakingbad/businessLogicLayer/cubit/character_cubit.dart';
import 'package:beakingbad/constants/strings.dart';
import 'package:beakingbad/data/Model/character_model.dart';
import 'package:beakingbad/data/repository/repository.dart';
import 'package:beakingbad/data/web_services/character_web_services.dart';
import 'package:beakingbad/presentation/Screens/HomeScreen.dart';
import 'package:beakingbad/presentation/Screens/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRoutes {
  //object from Cubit And  Repository
  late CharacterCubit characterCubit;
  late CharacterRepostory characterRepostory;
  MyRoutes() {
    characterRepostory = CharacterRepostory(CharacterWebServices());
    characterCubit = CharacterCubit(characterRepostory);
    //or
    // characterCubit = CharacterCubit(CharacterRepostory(CharacterWebServices()));
  }
  Route? myRoutes(RouteSettings route) {
    switch (route.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: ((context) => characterCubit),
            child: HomeScreen(),
          ),
        );
      case detailsCharacterScreen:
        final character = route.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CharacterCubit(characterRepostory),
                  child: detailsScreen(
                    character: character,
                  ),
                ));
      // default:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
