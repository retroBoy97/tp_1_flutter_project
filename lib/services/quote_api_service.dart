import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quote.dart';

part 'quote_api_service.g.dart';

@RestApi(baseUrl: "https://zenquotes.io/api")
abstract class QuoteApiService {
  factory QuoteApiService(Dio dio, {String? baseUrl}) = _QuoteApiService;

  @GET("/random")
  Future<List<Quote>> getRandomQuote();
}
