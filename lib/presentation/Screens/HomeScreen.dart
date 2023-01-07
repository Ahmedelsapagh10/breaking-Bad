import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beakingbad/businessLogicLayer/cubit/character_cubit.dart';
import 'package:beakingbad/businessLogicLayer/cubit/character_state.dart';
import 'package:beakingbad/constants/my_colors.dart';
import 'package:beakingbad/data/Model/character_model.dart';
import 'package:beakingbad/presentation/Widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> SearchedCharacters;
  bool _isSeearching = false;
  final _searchTextFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<CharacterCubit>().getAllCharacters();

    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget BodyBuildWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: ((context, state) {
      if (state is LoadedState) {
        allCharacters = state.characters;
        return LoadedStateWidget();
      } else {
        //
        return LoadingWidget();
      }
    }));
  }

  Widget LoadedStateWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
              itemCount: _searchTextFormController.text.isEmpty
                  ? allCharacters.length
                  : SearchedCharacters.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: _searchTextFormController.text.isEmpty
                      ? allCharacters[index]
                      : SearchedCharacters[index],
                );
              })
        ],
      ),
    );
  }

  Widget LoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        color: myColors.myYellow,
      ),
    );
  }

  Widget BuildSearchField() {
    return TextField(
      controller: _searchTextFormController,
      cursorColor: myColors.myGrey,
      style: TextStyle(
        color: myColors.myGrey,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: 'search',
        border: InputBorder.none,
        helperStyle: TextStyle(
          color: myColors.myGrey,
          fontSize: 18,
        ),
      ),
      onChanged: (String searchedCharacter) {
        SearchedCharacters = allCharacters
            .where(
              (character) =>
                  character.name.toLowerCase().startsWith(searchedCharacter),
            )
            .toList();
        setState(() {});
      },
    );
  }

// action
  List<Widget> buildAppBarAction() {
    if (_isSeearching) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _searchTextFormController.clear();
                Navigator.pop(context);
              });
            },
            icon: Icon(
              Icons.clear,
              color: myColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: Icon(
              Icons.search,
              color: myColors.myGrey,
            ))
      ];
    }
  }

  //onTap to Search
  void _startSearching() {
    // BackButton
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSeearching = false; // searchIcon
          _searchTextFormController.clear();
        });
      },
    ));
//ontap to search
    setState(() {
      _isSeearching = true; // x icon
    });
  }

  Widget titleWidget() {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 18,
        color: myColors.myGrey,
      ),
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        animatedTexts: [
          TypewriterAnimatedText('Breaking Bad'),
        ],
      ),
    );
  }

  Widget NoInterNetConnection() {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/9.gif',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                      blurRadius: 4,
                      color: Color.fromARGB(255, 0, 0, 0),
                      offset: Offset(0, 0))
                ],
              ),
              child: AnimatedTextKit(
                //totalRepeatCount: 2,
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText('No internet'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.myGrey,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: myColors.myYellow,
          title: _isSeearching ? BuildSearchField() : titleWidget(),
          actions: buildAppBarAction(),
          leading: _isSeearching
              ? BackButton(
                  color: myColors.myGrey,
                )
              : Container()),
      body: OfflineBuilder(
        child: Text(
          "No",
          style: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 255, 255, 255),
            shadows: [
              Shadow(
                  blurRadius: 4,
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(0, 0))
            ],
          ),
        ),
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BodyBuildWidget();
          } else {
            return NoInterNetConnection();
          }
        },
      ),

      // body: BodyBuildWidget(),
    );
  }
}
