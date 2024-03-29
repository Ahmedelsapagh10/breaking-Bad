import 'package:beakingbad/constants/strings.dart';
import 'package:beakingbad/data/Model/qouteModel.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  late Dio dio;
  CharacterWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getAllQuote(String authorName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': authorName});
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
