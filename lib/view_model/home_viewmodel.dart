
import 'package:eventapp/data/response/api_responses.dart';
import 'package:eventapp/model/events_model.dart';
import 'package:eventapp/repositeries/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeViewmodel with ChangeNotifier{
  final _myRepo = HomeRepository();

  ApiResponses<EventListModel> eventList = ApiResponses.loading();

  setEventsList(ApiResponses<EventListModel> response){
    eventList = response ;
    notifyListeners();
  }


  Future<void> fetchEventListApi ()async{

    setEventsList(ApiResponses.loading());

    _myRepo.fetchEventList().then((value){


      setEventsList(ApiResponses.completed(value));

    }).onError((error, stackTrace){

      setEventsList(ApiResponses.error(error.toString()));

    });
  }


}