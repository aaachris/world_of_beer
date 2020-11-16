import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';

import 'models/post_login_payload.dart';
import 'models/post_login_response.dart';
import 'models/post_register_payload.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://beer-workshop-dev.allaboutapps.at/api/v1/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/beers")
  Future<List<Beer>> getBeers(@Query("per_page") int pageSize, {@Query("page") int page = 1});

  @GET("/beers/{id}")
  Future<List<Beer>> getBeer(@Path("id") int id);

  @POST("/auth/register")
  Future<PostLoginResponse> register(@Body() PostRegisterPayload payload);

  @POST("/auth/login")
  Future<PostLoginResponse> login(@Body() PostLoginPayload payload);
}