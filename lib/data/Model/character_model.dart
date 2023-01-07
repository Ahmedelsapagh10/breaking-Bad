class CharacterModel {
  late int id;
  late String name;
  late String bithday;
  late List<dynamic> occupation;
  late String image;
  late String status;
  late List<dynamic> appearance;
  late String nickname;
  late String portrayed;
  late String categoty;
  late List<dynamic> appearanceInSoul;
  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json["char_id"];
    name = json["name"];
    bithday = json["birthday"];
    occupation = json["occupation"];
    image = json["img"];
    status = json["status"];
    appearance = json["appearance"];
    nickname = json["nickname"];
    portrayed = json["portrayed"];
    categoty = json["category"];
    appearanceInSoul = json["better_call_saul_appearance"];
  }
}
