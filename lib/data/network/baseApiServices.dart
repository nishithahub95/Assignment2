abstract class BaseApiServices{
  Future<dynamic>getGetApiResponses(String url);
  Future<dynamic>getGetEventApiResponses(String url);
  Future<dynamic>getPostApiResponses(String url,dynamic data);
}