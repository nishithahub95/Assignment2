import 'package:eventapp/data/response/status.dart';

class ApiResponses<T>{
  Status status;
  T? data;
  String? message;
  ApiResponses(this.status,this.data,this.message);
  ApiResponses.loading():status=Status.LOADING;
  ApiResponses.completed(this.data):status=Status.COMPLETED;
  ApiResponses.error(this.message):status=Status.ERROR;
  String toString(){
    return "status:$status\nData:$data\nmessage:$message";
  }
}