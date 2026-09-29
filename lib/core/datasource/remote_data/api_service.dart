import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newst_app/core/datasource/remote_data/api_config.dart';

class ApiService {

  static final ApiService _instance = ApiService._();

  ApiService._();
  factory ApiService (){
    return _instance;
  }

  final String baseUrl = "newsapi.org";
  final String apiKey = "5496816d97ed43a58f6dd6ecf280dc35";

  Future<dynamic> get(String endPoint, {Map<String, dynamic>? params}) async {
    var url = Uri.http(
      ApiConfig.baseUrl,
      "v2/$endPoint",

      {"apiKey": ApiConfig.apiKey, ...?params},

      //    'https://newsapi.org/v2/$endPoint
    );
    print(url);
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed to load Data ");

    }
  }
}
