import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app1/network/http/base_dio.dart';

//
// @RestApi(baseUrl: 'https://api.lishaoy.net')
// abstract class ApiClient {
//   factory ApiClient({Dio dio, String baseUrl}) {
//     dio ??= BaseDio.getInstance().getDio();
//     return _ApiClient(dio, baseUrl: baseUrl);
//
//     @POST('/login')
//     Future<LoginModel> login(@Body() Login login);
//   }
// }