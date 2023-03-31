
import 'package:eventapp/data/network/baseApiServices.dart';
import 'package:eventapp/data/network/networkApiservices.dart';
import 'package:eventapp/model/event.dart';
import 'package:eventapp/model/events_model.dart';
import 'package:eventapp/res/app_url.dart';

class HomeRepository{
  BaseApiServices _apiServices=NetworkApiServices();
  Future<EventListModel>fetchEventList()async{
    try{
      dynamic response=await _apiServices.getGetApiResponses(AppUrl.eventsEndPoint);
      return response=EventListModel.fromJson(response);

    }catch(e){
      throw e;
    }

  }
  Future<Eventsa>fetchEvent(int? id)async{
    try{

      dynamic response=await _apiServices.getGetEventApiResponses(AppUrl.singleeventEndpoint+'$id');
      return response=Eventsa.fromJson(response);

    }catch(e){
      throw e;
    }

  }
}