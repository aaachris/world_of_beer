import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:world_of_beer/app/network/models/beer_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.punkapi.com/v2/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/beers")
  Future<List<Beer>> getBeers(@Query("per_page") int pageSize, {@Query("page") int page = 1});

  @GET("/beers/{id}")
  Future<List<Beer>> getBeer(@Path("id") int id);

}