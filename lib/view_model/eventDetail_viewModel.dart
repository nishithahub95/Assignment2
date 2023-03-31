


import 'package:eventapp/data/response/api_responses.dart';
import 'package:eventapp/model/event.dart';
import 'package:eventapp/repositeries/home_repository.dart';
import 'package:flutter/material.dart';

class EventDetailViewmodel with ChangeNotifier{
  final _myRepo = HomeRepository();

  ApiResponses<Eventsa> event = ApiResponses.loading();

  setEvent(ApiResponses<Eventsa> response){
    event = response ;
    notifyListeners();
  }


  Future<void> fetchEventApi (int id)async{

    setEvent(ApiResponses.loading());

    _myRepo.fetchEvent(id).then((value){


      setEvent(ApiResponses.completed(value));

    }).onError((error, stackTrace){

      setEvent(ApiResponses.error(error.toString()));

    });
  }


}